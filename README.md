# MCP2515 #

Driver for MCP2515, a stand-alone CAN controller with SPI interface. The MCP2515 is capable of transmitting and receiving both standard and extended data and remote frames. It has three transmit buffers with prioritization and abort features and two receive buffers. To filter out unwanted messages the MCP2515 has two acceptance masks and six acceptance filters. [MCP2515 Datasheet](http://ww1.microchip.com/downloads/en/DeviceDoc/20001801H.pdf).

**Note** This driver class is still under development, so some features of the MCP2515 are not implemented yet.

To use this driver copy and paste the MCP2515.device.lib.nut file into your device code.

## Class Usage ##

### constructor(*spiBus[, chipSelectPin]*) ###

The class’ constructor takes one required parameter (a configured imp SPI bus) and an optional parameter (the chip select pin). The chip select pin will be configured by the constructor. If no chip select pin is provided the Imp API *spi.chipselect* method will be used to drive the chip select pin (NOTE: This method is only available on imps with a dedicated chip select pin and can only be used when the SPI bus is configured with **USE_CS_L** mode flag).

#### Parameters ####

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| *spiBus* | hardware.spi | N/A | A pre-configured SPI bus |
| *chipSelectPin* | hardware.pin | `null` | A chip select pin |

#### Example ####

```
spi <- hardware.spiBCAD;
cs  <- hardware.pinD;

// Configure SPI Mode 00, 1Mbit speed
spi.configure(CLOCK_IDLE_LOW, 1000);

// Initialize CAN Bus
canBus <- MCP2515(spi, cs);
```

## Class Methods ##

### init(*[optionsTable]*) ###

This method initializes the chip based on the settings in the *optionsTable*, and will reset the chip to get into an known state before applying the settings. If no settings table is passed in it will default to settings for a 10mHz clock with a transmit speed of 100kBPS, with no receive message filtering or interrupts enabled. For settings for other clock and speeds see [Timing Suggestions](#timing-suggestions) section.

#### Parameters ####

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| *optionsTable* | table | N/A | A table with configuration settings. See *Options* below. |

#### Options ####

| Parameter      | Type     | Default | Description |
| ---            | ---      | ---     | --- |
| *enFiltering*  | boolean  | `false` | Boolean whether to enable filtering. |
| *opMode*       | constant | MCP2515_OP_MODE_NORMAL | Sets the operation mode after configuration. Supported values: see [operation modes](#operation-modes) |
| *baudRatePre*  | integer  | 1 | Baud Rate Prescaler: Multiplier that keeps the Can Bit timing values in a programable range. Supported values: 1 - 128 |
| *propSeg*      | integer  | 1 | Propagation Segment: compensates for physical delays between node. Supported values: 1 - 8 |
| *phaseSeg1*    | integer  | 1 | Phase Segment 1: compensates for edge phase errors on the bus. Sample is taken at the end of Phase Segment 1. Supported values: 1-8 |
| *phaseSeg2*    | integer  | 2 | Phase Segment 2: compensates for edge phase errors on the bus. Supported values 2-8 |
| *sjw*          | integer  | 1 | Synchonization Jump Width: adjusts bit clock to keep in sync with transmitted message. Supported values: 1-4 |
| *samConfig*    | constant | MCP2515_SAM_3X | Sample Point Configuration: determines whether bus line is sampled one or three times at the sample point. Supported values: MCP2515_SAM_1X or MCP2515_SAM_3X |
| *enSOF*        | boolean  | `true` | Sets CLKOUT pin configuration. When `true`, enables SOF signal. When `false` enables clock out function. |
| *enWakeFilter* | boolean  | `false` | WakeUp Filter: `true` enables, `false` disables. |
| *intConfig*    | constant(s) | MCP2515_DISABLE_ALL_INTS | Configures interrupts. Supported values: see [Interrupt Settings](#interrupt-settings) |
| *configRxPins* | constant(s) | MCP2515_RXBF_PINS_DISABLE | Configures RX0BF and RX1BF pins. Supported values: see [RX Buffer Pin Settings](#rx-buffer-pin-settings) |
| *configTxPins* | constant(s) | MCP2515_TXRTS_PINS_DIG_IN | Configures TX Request To Send (RTS) pins. Supported values: see [TX RTS Pin Settings](#tx-rts-pin-settings) |

#### Return Value ####

Nothing.

#### Example ####
```
// Settings based on 10mHz clock, data tx speed 500kBPS, sampling 3X, filtering enabled, and interrupts when a message is received
canOpts <- {
    "enFiltering"  : true,
    "opMode"       : MCP2515_OP_MODE_NORMAL,
    "baudRatePre"  : 1,
    "propSeg"      : 2,
    "phaseSeg1"    : 4,
    "phaseSeg2"    : 3,
    "sjw"          : 1,
    "samConfig"    : MCP2515_SAM_3X,
    "intConfig"    : MCP2515_EN_INT_RXB0 | MCP2515_EN_INT_RXB1,
}

canBus.init(canOpts);
```

### setOpMode(*mode*) ###

Changes the opertation mode to the parameter *mode*.

#### Parameters ####

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| *mode* | constant | N/A | See *Operation Modes* below. |

#### Operation Modes ####

| Mode Constants | Description |
| --- | --- |
| MCP2515_OP_MODE_NORMAL | Normal mode is the standard operating mode. The device actively monitors all bus messages, and generates acks, error frames, etc. This is the only mode that will transmit messages over the CAN bus. |
| MCP2515_OP_MODE_SLEEP | Internal Sleep mode used to minimize the current consumption of the device. WakeUp can be configured to wake from sleep mode. When device wakes it will default to Listen Only Mode. |
| MCP2515_OP_MODE_LOOPBACK | Allows internal transmission of messages from the transmit buffers to the receive buffers without actually transmitting messages on the CAN bus. |
| MCP2515_OP_MODE_LISTEN_ONLY | Receives all messages in silent mode. No messages or acks will be transmitted in this mode. Used for monitoring applications or detecting baud rate in "hot plugging" situations. |
| MCP2515_OP_MODE_CONFIG | After power-up and reset the chip defaults to configuation mode. Used during initializaiton, and configuration of some registers. |

#### Return Value ####

A Mode Constant. This is the mode the chip is set to after updating the mode. Use this to confirm the mode is set correctly.

#### Example ####

```
local mode = canBus.setOpMode(MCP2515_OP_MODE_NORMAL);
if (mode != MCP2515_OP_MODE_NORMAL) server.error("Error: Not in normal mode.");
```

### reset() ###

This method triggers a SPI reset. This is functionally equivalent to a harware reset. It is important to reset after power-up to ensure that the logic and registers are in their default state. The init method will trigger a reset before configuring options. After reset the MCP2515 will automatically be set into *Configuration Mode*.

#### Return Value ####

Nothing.

#### Example ####

```
canBus.reset();
```

### configureInterrupts(*settings*)

This method configures what interrupts if any will trigger the inerrupt pin to change state.

#### Parameters ####

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| *settings* | constant(s) | N/A | Use the *Interrupt Constants* below to select the desired interrupt(s). If more than one interrupt is desired the constants can be *or-ed*. |

#### Interrupt Settings ####

| Interrupt Constants | Description |
| --- | --- |
| MCP2515_DISABLE_ALL_INTS | Disables all interrupts |
| MCP2515_EN_INT_RXB0 | Enables an interrupt on RX Buffer 0 |
| MCP2515_EN_INT_RXB1 | Enables an interrupt on RX Buffer 1 |
| MCP2515_EN_INT_TXB0 | Enables an interrupt on TX Buffer 0 |
| MCP2515_EN_INT_TXB1 | Enables an interrupt on TX Buffer 1 |
| MCP2515_EN_INT_TXB2 | Enables an interrupt on TX Buffer 2 |
| MCP2515_EN_INT_ERR | Enables an interrupt when error occurs |
| MCP2515_EN_INT_WAKE | Enables an interrupt when chip wakes from sleep mode |
| MCP2515_EN_INT_MSG_ERR | Enables an interrupt when an error occurs during message transmission or reception |

#### Return Value ####

Nothing.

#### Example ####

```
// Enable interrupts on all received messages
canBus.configureInterrupts(MCP2515_EN_INT_RXB0 | MCP2515_EN_INT_RXB1);
```

### configureRxBuffPins(*settings*)

This method configures RX0BF and RX1BF pins. See configuration settings below. To configure both pins constants can be *or-ed*.

#### Parameters ####

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| *settings* | constant(s) | N/A | Use the *RX Buffer Pin Constants* below to select the desired pin configuration settings. With the exeption of MCP2515_RXBF_PINS_DISABLE, constants can be *or-ed*. |

#### RX Buffer Pin Settings ####

| RX Buffer Pin Constants | Description |
| --- | --- |
| MCP2515_RXBF_PINS_DISABLE | Disables pin function for RX0BF and RX1BF, pins go to a high-impedance state |
| MCP2515_RX0BF_PIN_EN_INT | RX0BF pin is configured as an interrupt when a valid message is loaded into RXB0 |
| MCP2515_RX0BF_PIN_EN_DIG_OUT_HIGH | RX0BF pin is configured as a digital output, starting state high |
| MCP2515_RX0BF_PIN_EN_DIG_OUT_LOW | RX0BF pin is configured as a digital output, starting state low |
| MCP2515_RX1BF_PIN_EN_INT | RX1BF pin is configured as an interrupt when a valid message is loaded into RXB0 |
| MCP2515_RX1BF_PIN_EN_DIG_OUT_HIGH | RX1BF pin is configured as a digital output, starting state high |
| MCP2515_RX1BF_PIN_EN_DIG_OUT_LOW | RX1BF pin is configured as a digital output, starting state low |

#### Return Value ####

Nothing.

#### Example ####

```
// Enable interrupts on all received messages
canBus.configureRxBuffPins(MCP2515_RX0BF_PIN_EN_DIG_OUT_HIGH | MCP2515_RX1BF_PIN_EN_DIG_OUT_HIGH);
```

### configureTxRtsPins(*settings*)

This method configures TX0RTS, TX1RTS and TX2RTS pins. See configuration settings below. To configure multiple RTS pins constants can be *or-ed*.

#### Parameters ####

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| *settings* | constant(s) | N/A | Use the *TX RTS Pin Settings* below to select the desired pin configuration settings. RTS pin constants can be *or-ed*. |

#### TX RTS Pin Settings ####

| TX RTS Pin Constants | Description |
| --- | --- |
| MCP2515_TXRTS_PINS_DIG_IN | Configure TX0RTS, TX1RTS, and TX2RTS as digital inputs |
| MCP2515_TX0RTS_PIN_RTS | Configures TX0RTS as request message transmission of TXB0 buffer (on falling edge) |
| MCP2515_TX1RTS_PIN_RTS | Configures TX1RTS as request message transmission of TXB0 buffer (on falling edge) |
| MCP2515_TX2RTS_PIN_RTS | Configures TX2RTS as request message transmission of TXB0 buffer (on falling edge) |

#### Return Value ####

Nothing.

#### Example ####

```
// Enable TXRTS pins as digial inputs
canBus.configureRxBuffPins(MCP2515_TXRTS_PINS_DIG_IN);


// Enable TX0RTS and TX1RTS to request to send mode, and TX2RTS as a digital input.
canBus.configureRxBuffPins(MCP2515_TX0RTS_PIN_RTS | MCP2515_TX1RTS_PIN_RTS);
```

### configureFilter(*filterNum, ext, idFilter*)

This method configures filters to be applied to incoming messages.

#### Parameters ####

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| *filterNum* | integer | N/A | Accepted values: 0-5. Filters 0-1 will effect messages loaded into RX Buffer 0. Filters 2-5 effect messages loaded into RX Buffer 1. |
| *ext*       | boolean | N/A | If `true` the id filter will be applied to incoming extended messages, if `false` filter will be applied to incoming standard messages. |
| *idFilter*  | integer | N/A | Incoming messages with id's that match the *idFilter* will be loaded into the receive buffer. |

#### Return Value ####

Nothing.

#### Example ####

```
// Configure RX buffer 0 filters to only accept messages with standard ids of 5 and 10.
canBus.configureFilter(0, false, 5);
canBus.configureFilter(1, false, 10);
```

### configureMask(*maskNum, ext, idMask*)

This method configures the masks used to filter incoming messages. The length of the *idMask* parameter will determine if the mask is applied to standard or extended messages.

#### Parameters ####

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| *maskNum* | integer | N/A | Accepted values: 0-1. Mask 0 will effect messages loaded into RX Buffer 0. Mask 1 will effect messages loaded into RX Buffer 1. |
| *ext*     | boolean | N/A | If `true` the id mask will be applied to incoming extended messages, if `false` mask will be applied to incoming standard messages. |
| *idMask*  | integer | N/A | If id mask bit is set to `1` messages will only be loaded into the RX buffer if they match the filters for that buffer. If id mask bit is set to `0` filters for that bit will be bypassed. |

#### Return Value ####

Nothing.

#### Example ####

```
// Configure standard message mask for RX buffer 0.
canBus.configureFilter(0, false, 0x0F);
// Configure extended message mask for RX buffer 1.
canBus.configureFilter(1, true, 0x1F000000);
```

### enableMasksAndFilters(*enable*)

This method enables or disables message filtering based on the mask and filters set with *configureMask()* and *configureFilter()* methods.

#### Parameters ####

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| *enable* | boolean | N/A | If `true` enables, if set to `false` disables message filtering. |

#### Return Value ####

Nothing.

#### Example ####

```
// Enable message filtering
canBus.enableMasksAndFilters(true);

// Disable message filtering
canBus.enableMasksAndFilters(false);
```

### clearFiltersAndMasks()

This method sets all masks and filters to default state - all mask and filter ids set to zero.

#### Return Value ####

Nothing.

#### Example ####

```
// Enable interrupts on all received messages
canBus.clearFiltersAndMasks();
```

### readMsg()



### getError()


## Timing Notes ##

### Timing Suggestions ###

| Clock Rate | Bus Speed | Baud Rate Prescaler | Propagation Segment | Phase Segment 1 | Phase Segment 2 | Synchonization Jump Width |
| --- | --- | --- | --- | --- | --- | --- |
| 8mHz | 1000kBPS |  |  |  |  |  |
| 8mHz | 500kBPS |  |  |  |  |  |
| 8mHz | 250kBPS |  |  |  |  |  |
| 8mHz | 200kBPS |  |  |  |  |  |
| 8mHz | 125kBPS |  |  |  |  |  |
| 8mHz | 100kBPS |  |  |  |  |  |
| 8mHz | 80kBPS |  |  |  |  |  |
| 8mHz | 50kBPS |  |  |  |  |  |
| 8mHz | 40kBPS |  |  |  |  |  |
| 8mHz | 33k3BPS |  |  |  |  |  |
| 8mHz | 31k25BPS |  |  |  |  |  |
| 8mHz | 20kBPS |  |  |  |  |  |
| 8mHz | 10kBPS |  |  |  |  |  |
| 8mHz | 5kBPS |  |  |  |  |  |
| 10mHz | 1000kBPS | 1 | 1 | 1 | 2 | 1 |
| 10mHz | 500kBPS | 1 | 2 | 4 | 3 | 1 |
| 10mHz | 250kBPS | 1 | 7 | 7 | 5 | 2 |
| 10mHz | 125kBPS | 2 | 7 | 7 | 5 | 2 |
| 10mHz | 100kBPS | 5 | 4 | 3 | 2 | 2 |
| 10mHz | 50kBPS | 5 | 7 | 7 | 5 | 2 |
| 10mHz | 40kBPS | 5 | 8 | 8 | 8 | 4 |
| 10mHz | 20kBPS | 25 | 4 | 3 | 2 | 1 |
| 16mHz | 1000kBPS |  |  |  |  |  |
| 16mHz | 500kBPS |  |  |  |  |  |
| 16mHz | 250kBPS |  |  |  |  |  |
| 16mHz | 200kBPS |  |  |  |  |  |
| 16mHz | 125kBPS |  |  |  |  |  |
| 16mHz | 100kBPS |  |  |  |  |  |
| 16mHz | 80kBPS |  |  |  |  |  |
| 16mHz | 50kBPS |  |  |  |  |  |
| 16mHz | 40kBPS |  |  |  |  |  |
| 16mHz | 33k3BPS |  |  |  |  |  |
| 16mHz | 20kBPS |  |  |  |  |  |
| 16mHz | 10kBPS |  |  |  |  |  |
| 16mHz | 5kBPS |  |  |  |  |  |
| 20mHz | 1000kBPS | 1 | 2 | 4 | 3 | 1 |
| 20mHz | 500kBPS | 1 | 7 | 7 | 5 | 2 |
| 20mHz | 250kBPS | 2 | 7 | 7 | 5 | 2 |
| 20mHz | 200kBPS | 5 | 4 | 3 | 2 | 2 |
| 20mHz | 125kBPS | 5 | 6 | 5 | 4 | 2 |
| 20mHz | 100kBPS | 5 | 7 | 7 | 5 | 2 |
| 20mHz | 80kBPS | 5 | 8 | 8 | 8 | 4 |
| 20mHz | 50kBPS | 10 | 7 | 7 | 5 | 2 |
| 20mHz | 40kBPS | 25 | 4 | 3 | 2 | 1 |