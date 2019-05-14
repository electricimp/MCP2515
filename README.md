# MCP2515 #

This library provides a driver for the [Microchip MCP2515](https://www.microchip.com/wwwproducts/en/en010406), a standalone Controller Area Network (CAN) controller with a SPI interface. The MCP2515 is capable of transmitting and receiving both standard and extended data, and remote frames. It has three transmit buffers with prioritization and abort features, and two receive buffers. To filter out unwanted messages, the MCP2515 has two acceptance masks and six acceptance filters. You can [download the MCP2515 Datasheet here](http://ww1.microchip.com/downloads/en/DeviceDoc/MCP2515-Stand-Alone-CAN-Controller-with-SPI-20001801J.pdf).

**Note** This driver is still under development. Not all of the MCP2515’s features have yet been implemented. Currently, message reception and very basic message transmission are implemented, and only 10MHz clock [timing suggestions](#timing-suggestions) have been tested.

**To include this driver in your project, paste the contents of the** `MCP2515.device.lib.nut` **file at the top of your device code.**

## Class Usage ##

### constructor(*spiBus[, chipSelectPin]*) ###

The driver is instantiated with a pre-configured imp SPI bus object and, optionally, an imp pin object to which the Chip Select (CS) line is connected. The chip select pin will be configured by the constructor, though the SPI bus will not be. If no CS pin is specified, the imp API method [**spi.chipselect()**](https://developer.electricimp.com/api/hardware.spi/chipselect) will be used to drive the CS pin.

**Note** [**spi.chipselect()**](https://developer.electricimp.com/api/hardware.spi/chipselect) is only available on imps with a dedicated chip select pin and can only be used when the SPI bus is configured with **USE_CS_L** mode flag.

#### Parameters ####

| Parameter | Type | Required? | Description |
| --- | --- | --- | --- |
| *spiBus* | imp **hardware.spi** object | Yes | A pre-configured SPI bus |
| *chipSelectPin* | imp **hardware.pin** object | No | A chip select pin. Default: `null` |

#### Example ####

```squirrel
spi <- hardware.spiBCAD;
cs  <- hardware.pinD;

// Configure SPI bus to Mode 00, 1Mbit speed
spi.configure(CLOCK_IDLE_LOW, 1000);

// Initialize CAN Bus
canBus <- MCP2515(spi, cs);
```

## Class Methods ##

### init(*[settings]*) ###

This method initializes the MCP2515 based on the settings specified, if any, in the table passed into *settings*. It will reset the MCP2515 to get into an known state before applying the settings. If no settings table is passed in, default settings will be applied: a 10MHz clock with a transmit speed of 1000Kb/s and no receive message filtering or interrupts enabled. For possible clock and speed settings, please see [‘Timing Notes’](#timing-notes), below.

#### Parameters ####

| Parameter | Type | Required? | Description |
| --- | --- | --- | --- |
| *settings* | Table | No | A table containing desired configuration information (see [MCP2515 Settings](#mcp2515-settings), below) |

#### MCP2515 Settings ####

| Parameter | Type | Description |
| --- | --- | --- |
| *enFiltering* | Boolean | Whether filtering should be enabled (`true`) or not (`false`). Default: `false` |
| *opMode* | Constant | The operation mode after configuration. For supported values, please see [‘Operation Mode Constants’](#operation-mode-constants), below. Default: *MCP2515_OP_MODE_NORMAL* |
| *baudRatePre* | Integer | Baud Rate Pre-scaler. A multiplier that keeps the CAN bit-timing values in a programable range. Supported values: 1-128. Default: 1 |
| *propSeg* | Integer | Propagation Segment. Compensates for physical delays between nodes. Supported values: 1-8. Default: 1 |
| *phaseSeg1* | Integer | Phase Segment 1. Compensates for edge phase errors on the bus. Sample is taken at the end of phase segment 1. Supported values: 1-8. Default: 1 |
| *phaseSeg2* | Integer | Phase Segment 2. Compensates for edge phase errors on the bus. Supported values 2-8. Default: 2 |
| *sjw* | integer | Synchronization Jump Width. Adjusts the bit clock to keep in sync with transmitted message. Supported values: 1-4. Default: 1 |
| *samConfig* | Constant | Sample point Configuration. Determines whether the bus line is sampled once or three times at the sample point. Supported values: *MCP2515_SAM_1X* or *MCP2515_SAM_3X*. Default: *MCP2515_SAM_3X* |
| *enSOF* | Boolean | Sets CLKOUT pin configuration. When `true`, enables SOF signal; when `false`, enables clock out function. Default: `true` |
| *enWakeFilter* | Boolean | Enable the Wake Filter: `true` enables the filter, `false` disables it. Default: `false` |
| *intConfig* | Constant | Configures interrupts. For supported values, please see [‘Interrupt Configuration Constants’](#interrupt-configuration-constants). Default: *MCP2515_DISABLE_ALL_INTS* |
| *configRxPins* | Constant | Configure the RX0BF and RX1BF pins. For supported values, please see [‘RX Buffer Pin Constants’](#rx-buffer-pin-constants), below. Default: *MCP2515_RXBF_PINS_DISABLE* |
| *configTxPins* | Constant | Configures the TX Request To Send (RTS) pins. For supported values, please see [‘TX RTS Pin Constants’](#tx-rts-pin-constants), below. Default: *MCP2515_TXRTS_PINS_DIG_IN* |

#### Return Value ####

Nothing.

#### Example ####

```squirrel
// Settings based on 10MHz clock, data TX speed 500Kb/s, sampling 3x,
// filtering enabled, and interrupts when a message is received
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

This method changes the operation mode to the specified value.

#### Parameters ####

| Parameter | Type | Required? | Description |
| --- | --- | --- | --- |
| *mode* | Constant | No | See [‘Operation Mode Constants’](#operation-mode-constants), below |

#### Operation Mode Constants ####

| Integer Constant | Description |
| --- | --- |
| *MCP2515_OP_MODE_NORMAL* | Normal mode is the standard operating mode. The device actively monitors all bus messages, and generates ACKs, error frames, etc. This is the only mode that will transmit messages over the CAN bus |
| *MCP2515_OP_MODE_SLEEP* | Internal Sleep mode. Used to minimize the current consumption of the device. Wakeup can be configured to wake from sleep mode. When device wakes it will default to *MCP2515_OP_MODE_LISTEN_ONLY* mode |
| *MCP2515_OP_MODE_LOOPBACK* | Allows internal transmission of messages from the transmit buffers to the receive buffers without transmitting messages on the CAN bus |
| *MCP2515_OP_MODE_LISTEN_ONLY* | Receives all messages in silent mode. No messages or ACKs will be transmitted in this mode. Used for monitoring applications or detecting baud rate in "hot plugging" situations |
| *MCP2515_OP_MODE_CONFIG* | After power-up and reset, the chip defaults to configuration mode. Used during device initialization, and configuration of some registers |

#### Return Value ####

Integer &mdash; The mode the chip has been set to. Use this to confirm the mode is set correctly.

#### Example ####

```squirrel
local mode = canBus.setOpMode(MCP2515_OP_MODE_NORMAL);
if (mode != MCP2515_OP_MODE_NORMAL) server.error("Error: Not in normal mode.");
```

### reset() ###

This method triggers a SPI reset. This is functionally equivalent to a hardware reset. It is important to reset after power-up to ensure that the logic and registers are in their default state. The [*init()*](#initsettings) method will trigger a reset before applying any specified configuration options. After reset, the MCP2515 will automatically be placed in configuration mode (see [‘Operation Mode Constants’](#operation-mode-constants), above).

#### Return Value ####

Nothing.

#### Example ####

```squirrel
canBus.reset();
```

### configureInterrupts(*interrupts*) ###

This method configures which interrupts, if any, will trigger the interrupt pin to change state.

#### Parameters ####

| Parameter | Type | Required? | Description |
| --- | --- | --- | --- |
| *interrupts* | Integer bitfield | Yes | Use the [interrupt configuration constants](#interrupt-configuration-constants) below to select the desired interrupt(s). With the exception of *MCP2515_DISABLE_ALL_INTS*, the constants can be OR’d to apply multiple values (see example, below) |

#### Interrupt Configuration Constants ####

| Integer Constant | Description |
| --- | --- |
| *MCP2515_EN_INT_RXB0* | Enables an interrupt on RX Buffer 0 |
| *MCP2515_EN_INT_RXB1* | Enables an interrupt on RX Buffer 1 |
| *MCP2515_EN_INT_TXB0* | Enables an interrupt on TX Buffer 0 |
| *MCP2515_EN_INT_TXB1* | Enables an interrupt on TX Buffer 1 |
| *MCP2515_EN_INT_TXB2* | Enables an interrupt on TX Buffer 2 |
| *MCP2515_EN_INT_WAKE* | Enables an interrupt when chip wakes from sleep mode |
| *MCP2515_EN_INT_MSG_ERR* | Enables an interrupt when an error occurs during message transmission or reception |
| *MCP2515_EN_INT_ERR* | Enables an interrupt when any other error occurs |
| *MCP2515_DISABLE_ALL_INTS* | Disables all interrupts |

#### Return Value ####

Nothing.

#### Example ####

```squirrel
// Enable interrupts on all received messages
canBus.configureInterrupts(MCP2515_EN_INT_RXB0 | MCP2515_EN_INT_RXB1);
```

### configureRxBuffPins(*pinSettings*) ###

This method configures the MCP2515’s RX0BF and/or RX1BF pins.

#### Parameters ####

| Parameter | Type | Required? | Description |
| --- | --- | --- | --- |
| *pinSettings* | Integer bitfield | Yes | Use any of the [RX buffer pin constants](#rx-buffer-pin-constants) below to select the desired pin configuration. With the exception of *MCP2515_RXBF_PINS_DISABLE*, the constants can be OR’d to apply multiple values (see example, below) |

#### RX Buffer Pin Constants ####

| Constant | Description |
| --- | --- |
| *MCP2515_RX0BF_PIN_EN_INT* | The RX0BF pin is configured as an interrupt when a valid message is loaded into RXB0 |
| *MCP2515_RX0BF_PIN_EN_DIG_OUT_HIGH* | The RX0BF pin is configured as a digital output, starting state high |
| *MCP2515_RX0BF_PIN_EN_DIG_OUT_LOW* | The RX0BF pin is configured as a digital output, starting state low |
| *MCP2515_RX1BF_PIN_EN_INT* | The RX1BF pin is configured as an interrupt when a valid message is loaded into RXB1 |
| *MCP2515_RX1BF_PIN_EN_DIG_OUT_HIGH* | The RX1BF pin is configured as a digital output, starting state high |
| *MCP2515_RX1BF_PIN_EN_DIG_OUT_LOW* | The RX1BF pin is configured as a digital output, starting state low |
| *MCP2515_RXBF_PINS_DISABLE* | Disables pin function for RX0BF and RX1BF. The pins go to a high-impedance state |

#### Return Value ####

Nothing.

#### Example ####

```squirrel
// Enable interrupts on all received messages
canBus.configureRxBuffPins(MCP2515_RX0BF_PIN_EN_DIG_OUT_HIGH | MCP2515_RX1BF_PIN_EN_DIG_OUT_HIGH);
```

### configureTxRtsPins(*pinSettings*) ###

This method configures the TX0RTS, TX1RTS and/or TX2RTS pins.

#### Parameters ####

| Parameter | Type | Required? | Description |
| --- | --- | --- | --- |
| *pinSettings* | Integer bitfield | Yes | Use any of the [TX RTS pin constants](#tx-rts-pin-constants) below to select the desired pin configuration settings. The constants can be OR’d to apply multiple values |

#### TX RTS Pin Constants ####

| Constant | Description |
| --- | --- |
| *MCP2515_TXRTS_PINS_DIG_IN* | Configure TX0RTS, TX1RTS and TX2RTS as digital inputs |
| *MCP2515_TX0RTS_PIN_RTS* | Configures TX0RTS as request message transmission of TXB0 buffer (on falling edge) |
| *MCP2515_TX1RTS_PIN_RTS* | Configures TX1RTS as request message transmission of TXB1 buffer (on falling edge) |
| *MCP2515_TX2RTS_PIN_RTS* | Configures TX2RTS as request message transmission of TXB2 buffer (on falling edge) |

#### Return Value ####

Nothing.

#### Example ####

```squirrel
// Enable TXRTS pins as digital inputs
canBus.configureRxBuffPins(MCP2515_TXRTS_PINS_DIG_IN);

// Enable TX0RTS and TX1RTS to request to send mode, and TX2RTS as a digital input
canBus.configureRxBuffPins(MCP2515_TX0RTS_PIN_RTS | MCP2515_TX1RTS_PIN_RTS);
```

### enableMasksAndFilters(*enable*) ###

This method enables or disables message filtering based on the mask and filters set with [*configureMask()*](#configuremaskmasknum-maskid) and [*configureFilter()*](#configurefilterfilternum-extended-filterid) methods.

#### Parameters ####

| Parameter | Type | Required? | Description |
| --- | --- | --- | --- |
| *enable* | Boolean | Yes | Enable (`true`) or disable (`false`) message filtering |

#### Return Value ####

Nothing.

#### Example ####

```squirrel
// Enable message filtering
canBus.enableMasksAndFilters(true);

// Disable message filtering
canBus.enableMasksAndFilters(false);
```

### clearFiltersAndMasks() ###

This method sets all masks and filters to the default state: all mask and filter IDs are set to `0`.

#### Return Value ####

Nothing.

#### Example ####

```squirrel
// Enable interrupts on all received messages
canBus.clearFiltersAndMasks();
```

### configureMask(*buffer, mask*) ###

This method configures the masks which are used to filter incoming messages. The mask governs whether messages are filtered or not. If a mask bit is `0`, no filtering is applied; if the mask bit is `1`, the message ID bit is filtered: the message will only be accepted if the message ID bit matches the filter ID bit.

**Note** The [*init()*](#initsettings) method configures all mask registers to `0`. As such, all messages will be accepted until masks have been configured.

#### Parameters ####

| Parameter | Type | Required? | Description |
| --- | --- | --- | --- |
| *buffer* | Integer | Yes | The buffer to which the specified mask will be applied. Accepted values: 0 (RX Buffer 0) or 1 (RX Buffer 1) |
| *mask* | 16-bit integer bitfield | Yes | For a given mask bit, if it is set to `1`, messages will only be loaded into the RX buffer if their IDs match the filters for that buffer. If the bit is cleared, filters for that buffer will be bypassed |

#### Return Value ####

Nothing.

#### Example ####

```
// Configuring mask 0 on RX buffer 0 to filter on standard message IDs
canBus.configureMask(0, 0x7FF);
// Configuring mask 1 on RX buffer 1 to filter on standard message IDs
canBus.configureMask(1, 0x7FF);

canBus.enableMasksAndFilters(true);
```

### configureFilter(*filterNumber, extended, filterID*) ###

This method configures filters that will be applied to incoming messages.

**Note** The [*init()*](#initsettings) method configures all mask registers to `0`, bypassing filters. For filters to take effect, masks must be configured using [*configureMask()*](#configuremaskbuffer-mask).

#### Parameters ####

| Parameter | Type | Required? | Description |
| --- | --- | --- | --- |
| *filterNumber* | Integer | Yes | Accepted values: 0-5. Filters 0-1 operate upon messages loaded into RX Buffer 0. Filters 2-5 operate upon messages loaded into RX Buffer 1 |
| *extended* | Boolean | Yes | If `true`, the filter will be applied to extended-format messages; if `false`, the filter will be applied to standard-format messages |
| *filterID* | 16-bit integer bitfield | Yes | Incoming messages with IDs that match the *filterID* will be loaded into the receive buffer |

#### Return Value ####

Nothing.

#### Example ####

```squirrel
// Configuring mask 0 on RX buffer 0 to filter on standard message IDs
canBus.configureMask(0, 0x7FF);
// Configuring mask 1 on RX buffer 1 to filter on standard message IDs
canBus.configureMask(1, 0x7FF);

// Configure RX buffer 0 filters to only accept messages with standard IDs of 5 and 10
canBus.configureFilter(0, false, 0x05);
canBus.configureFilter(1, false, 0x0A);

// Begin filtering
canBus.enableMasksAndFilters(true);
```

### readMsg() ###

This method checks for messages in the buffer. If a message is found, it is returned, otherwise the method returns `null`.

#### Return Value ####

Table &mdash; a decoded message, as below, or `null` if there is no pending message.

| Key | Value&nbsp;Type | Value |
| --- | --- | --- |
| *id* | Integer | The message ID |
| *data* | Blob | The message data |
| *extended* | Boolean | `true` if message is in extended format |
| *rtr* | Boolean | `true` if a remote transmit was requested |
| *rtrReceived* | Boolean | `true` if a remote transfer request was received |

#### Example ####

```squirrel
// Enable interrupts on all received messages
local message = canBus.readMsg();
if (message != null) {
    server.log("Message received with id: " + message.id);
    server.log(message.data);
}
```

### sendMsg(*message[, buffer]*) ###

This method writes message to the specified buffer. If no buffer is specified, the message will be sent to transmit control buffer 0. Whichever buffer is chosen, it is flagged as ‘transmission pending’. The message priority is set to lowest available value.

#### Parameters ####

| Parameter | Type | Required? | Description |
| --- | --- | --- | --- |
| *message* | Table | Yes | See [below](#message-table) for the keys you must include in the message table |
| *buffer* | Integer | No | Transmit buffer to be used. Supported values: 0, 1, 2. If an invalid buffer is selected, the default will be used. Default: 0 |

#### Return Value ####

Integer &mdash; The contents of the buffer’s control register.

#### Message Table ####

All keys are required.

| Key | Value&nbsp;Type | Value |
| --- | --- | --- |
| *id* | Integer | The message ID |
| *data* | Blob | The message data |
| *extended* | Boolean | `true` if message is in extended format. Extended format is not currently supported. If set to `true`, no message will be sent and an error message will be logged |
| *rtr* | Boolean | `true` if remote transmit requested |

#### Example ####

```squirrel
local msg = {"id"       : 0x14,
             "data"     : 0x01,
             "extended" : false,
             "rtr"      : false };
canBus.sendMsg(msg);
```

### getError() ###

This method reads the error register and returns a table with error status information.

#### Return Value ####

Table &mdash; an error status table:

| Key | Value&nbsp;Type | Value |
| --- | --- | --- |
| *errorFound* | Boolean | `true` if any error conditions have been detected |
| *rxB1Overflow* | Boolean | `true` when a valid message is received for RX buffer 1 |
| *rxB0Overflow* | Boolean | `true` when a valid message is received for RX buffer 0 |
| *txBusOff* | Boolean | `true` when TX error counter reaches 255 |
| *txErrorPassive* | Boolean | `true` when TX error counter reaches 128 |
| *rxErrorPassive* | Boolean | `true` when RX error counter reaches 128 |
| *txErrorWarning* | Boolean | `true` when TX error counter reaches 96 |
| *rxErrorWarning* | Boolean | `true` when RX error counter reaches 96 |
| *txRxErrorWarning* | Boolean | `true` when TX or RX error counter is equal to or greater than 96 |

#### Example ####

```squirrel
// Log errors
local errors = canBus.getError();
if (errors.errorFound) {
    foreach(error, state in errors) {
        if (state) server.log(error);
    }
}
```

## Timing Notes ##

**Note** The following bit timing guidance comes from [‘Application Notes For MCP2510’](http://ww1.microchip.com/downloads/en/AppNotes/00739a.pdf).

Every bit time is made up of four segments:

1. Synchronization Segment (SyncSeg)
2. Propagation Segment (PropSeg)
3. Phase Segment 1 (PS1)
4. Phase Segment 2 (PS2)

Each of these segments are made up of integer units called Time Quanta (TQ). The base TQ is defined as 2 Tosc. The TQ time can be modified by changing the “Baud Rate Pre-scaler”. The sample point occurs between PS1 and PS2 and is the point where the bit level is sampled to determine whether it is dominant or recessive. By changing the TQ number in the bit segments and/or the baud rate pre-scaler, it is possible to change the bit length and move the sample point around in the bit.

```
| Sync Segment | Prop Segment | Phase 1 Segment   | Phase 2 Segment   |
+ ------------ + ------------ + ----------------- + ----------------- +
| 1 TQ         | 1 - 8 TQ     | 1 - 8 TQ          | 2 - 8 TQ          |
|              |              | Sample Point ---> | <--- Sample Point |
```

There are additional definitions that are needed to understand the bit timing settings:

* Information Processing Time (IPT) &mdash; The time it takes to determine the value of the bit. The IPT occurs after the sample point and is fixed at 2 TQ.
* Synchronization Jump Width (SJW) &mdash; Can be programmed from 1-4 TQ and is the amount that PS1 can lengthen or PS2 can shorten so the receiving node can maintain synchronization with the transmitter.
* Bus Delay Times (TDELAY) &mdash; This delay time is the physical delays as a result of the physical layer (length, material, transceiver characteristics, etc).

There are four rules that must be adhered to when programming the timing segments:

1. PS2 ≥ IPT &mdash; Phase Segment 2 must be greater than or equal to the Information Processing Time (IPT) so that the bit level can be determined and processed by the CAN module before the beginning of the next bit in the stream. The IPT = 2 TQ so PS2(min) = 2 TQ.
2. PropSeg + PS1 ≥ PS2 &mdash; This requirement ensures the sample point is greater than 50 per cent of the bit time.
3. PS2 > SJW &mdash; PS2 must be larger than the SJW to avoid shortening the bit time to before the sample point. For example, if PS2 = 2 and SJW = 3, then a re-synchronization to shorten the bit would place the end of the bit time at 1 TQ before the sample point.
4. PropSeg + PS1 ≥ TDELAY &mdash; This requirement ensures there is adequate time before the sample point. In fact, the PropSeg should be set to compensate for physical bus delays.

### Timing Suggestions ###

| Clock<br />Rate | Bus<br />Speed | Baud&nbsp;Rate<br />Pre-scaler | Prop&nbsp;Seg.<br />&nbsp; | Phase&nbsp;Seg.<br />1 | Phase&nbsp;Seg.<br />2 | SJW<br />&nbsp; |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 8MHz | 1000Kb/s | 1 | 1 | 1 | 1 | 1 |
| 8MHz | 500Kb/s | 1 | 2 | 3 | 2 | 1 |
| 8MHz | 250Kb/s | 1 | 6 | 5 | 4 | 3 |
| 8MHz | 200Kb/s | 1 | 7 | 7 | 5 | 3 |
| 8MHz | 125Kb/s | 2 | 6 | 5 | 4 | 3 |
| 8MHz | 100Kb/s | 2 | 7 | 7 | 5 | 3 |
| 8MHz | 80Kb/s | 5 | 4 | 3 | 2 | 1 |
| 8MHz | 50Kb/s | 5 | 6 | 5 | 4 | 3 |
| 8MHz | 40Kb/s | 5 | 7 | 7 | 5 | 3 |
| 8MHz | 33.3Kb/s | 6 | 7 | 7 | 5 | 3 |
| 8MHz | 31.25Kb/s | 8 | 6 | 5 | 4 | 3 |
| 8MHz | 20Kb/s | 10 | 7 | 7 | 5 | 3 |
| 8MHz | 10Kb/s | 19 | 7 | 7 | 5 | 3 |
| 8MHz | 5Kb/s | 39 | 7 | 7 | 5 | 3 |
| 10MHz | 1000Kb/s | 1 | 1 | 1 | 2 | 1 |
| 10MHz | 500Kb/s | 1 | 2 | 4 | 3 | 1 |
| 10MHz | 250Kb/s | 1 | 7 | 7 | 5 | 2 |
| 10MHz | 125Kb/s | 2 | 7 | 7 | 5 | 2 |
| 10MHz | 100Kb/s | 5 | 4 | 3 | 2 | 1 |
| 10MHz | 50Kb/s | 5 | 7 | 7 | 5 | 2 |
| 10MHz | 40Kb/s | 5 | 8 | 8 | 8 | 4 |
| 10MHz | 20Kb/s | 25 | 4 | 3 | 2 | 1 |
| 16MHz | 1000Kb/s | 1 | 3 | 2 | 2 | 1 |
| 16MHz | 500Kb/s | 1 | 6 | 5 | 4 | 2 |
| 16MHz | 250Kb/s | 2 | 6 | 5 | 4 | 2 |
| 16MHz | 200Kb/s | 2 | 7 | 7 | 5 | 2 |
| 16MHz | 125Kb/s | 4 | 6 | 5 | 4 | 2 |
| 16MHz | 100Kb/s | 5 | 6 | 5 | 4 | 2 |
| 16MHz | 80Kb/s | 5 | 7 | 7 | 5 | 2 |
| 16MHz | 50Kb/s | 8 | 7 | 7 | 5 | 2 |
| 16MHz | 40Kb/s | 10 | 7 | 7 | 5 | 2 |
| 16MHz | 33.3Kb/s | 15 | 6 | 5 | 4 | 2 |
| 16MHz | 20Kb/s | 19 | 7 | 7 | 5 | 2 |
| 16MHz | 10Kb/s | 39 | 7 | 7 | 5 | 2 |
| 16MHz | 5Kb/s | 63 | 8 | 8 | 8 | 1 |
| 20MHz | 1000Kb/s | 1 | 2 | 4 | 3 | 1 |
| 20MHz | 500Kb/s | 1 | 7 | 7 | 5 | 2 |
| 20MHz | 250Kb/s | 2 | 7 | 7 | 5 | 2 |
| 20MHz | 200Kb/s | 5 | 4 | 3 | 2 | 1 |
| 20MHz | 125Kb/s | 5 | 6 | 5 | 4 | 2 |
| 20MHz | 100Kb/s | 5 | 7 | 7 | 5 | 2 |
| 20MHz | 80Kb/s | 5 | 8 | 8 | 8 | 4 |
| 20MHz | 50Kb/s | 10 | 7 | 7 | 5 | 2 |
| 20MHz | 40Kb/s | 25 | 4 | 3 | 2 | 1 |