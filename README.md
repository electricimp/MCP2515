# MCP2515 #

Driver for MCP2515, a stand-alone CAN controller with SPI interface. [MCP2515 Datasheet](http://ww1.microchip.com/downloads/en/DeviceDoc/20001801H.pdf)

## Class Usage ##

### constructor(*spiBus[, chipSelectPin]*) ###

The class’ constructor takes one required parameter (a configured imp SPI bus) and an optional parameter (the chip select pin). The chip select pin will be configured by the constructor. If no chip select pin is provided the Imp API *spi.chipselect* method will be used to drive the chip select pin (NOTE: This method is only available on imps with a dedicated chip select pin and can only be used when the SPI bus is configured with **USE_CS_L** mode flag)

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

### init(*optionsTable*) ###

#### Parameters ####

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| *optionsTable* | table | N/A | A table with configuration settings. See below. |

#### Options ####

| Parameter      | Type     | Default | Description |
| ---            | ---      | ---     | --- |
| *enFiltering*  | boolean  | `false` | Boolean whether to enable filtering. |
| *opMode*       | constant | MCP2515_OP_MODE_NORMAL | Sets the operation mode after configuration. Supported values: see [operation modes](#operation-modes) | 
| *baudRatePre*  | integer  | 1 | Baud Rate Prescaler: Multiplier that keeps the Can Bit timing values in a programable range. Supported values: 1 - 8 |
| *propSeg*      | integer  | 1 | Propagation Segment: compensates for physical delays between node. Supported values: 1 - 8 |
| *phaseSeg1*    | integer  | 1 | Phase Segment 1: compensates for edge phase errors on the bus. Sample is taken at the end of Phase Segment 1. Supported values: 1-8 |
| *phaseSeg2*    | integer  | 2 | Phase Segment 2: compensates for edge phase errors on the bus. Supported values 2-8 |
| *sjw*          | integer  | 1 | Synchonization Jump Width: adjusts bit clock to keep in sync with transmitted message. Supported values: 1-4 |
| *samConfig*    | constant | MCP2515_SAM_3X | Sample Point Configuration: determines whether bus line is sampled one or three times at the sample point. Supported values: MCP2515_SAM_1X or MCP2515_SAM_3X |
| *enSOF*        | boolean  | `true` | Sets CLKOUT pin configuration. When `true`, enables SOF signal. When `false` enables clock out function. |
| *enWakeFilter* | boolean  | `false` | WakeUp Filter: `true` enables, `false` disables. |
| *intConfig*    | constant(s) | MCP2515_EN_INT_RXB0 &#124; MCP2515_EN_INT_RXB1 | Configures interrupts. Supported values: see [Interrupt Settings](#interrupt-settings) |
| *configRxPins* | constant(s) | MCP2515_RXBF_PINS_DISABLE | Configures RX0BF and RX1BF pins. Supported values: see [RX Buffer Pin Settings](#rx-buffer-pin-settings) |
| *configTxPins* | constant(s) | MCP2515_TXRTS_PINS_DIG_IN | Configures TX Request To Send (RTS) pins. Supported values: see [TX RTS Pin Settings](#tx-rts-pin-settings) |

#### Return Value ####

Nothing.

#### Example ####
```
// Settings based on 10mHz clock, data tx speed 500kBPS
// Disable masks and filters, BRP = 1, propSeg = 2, phaseSeg1 = 4, phaseSeg2 = 3, SJW = 1
canOpts <- {
    "enFiltering"  : true,
    "opMode"       : MCP2515_OP_MODE_NORMAL,
    "baudRatePre"  : 1, 
    "propSeg"      : 2, 
    "phaseSeg1"    : 4, 
    "phaseSeg2"    : 3,
    "sjw"          : 1, 
    "samConfig"    : MCP2515_SAM_3X,
    "enSOF"        : true,
    "enWakeFilter" : false,
    "intConfig"    : MCP2515_EN_INT_RXB0 | MCP2515_EN_INT_RXB1,
    "configRxPins" : MCP2515_RXBF_PINS_DISABLE,
    "configTxPins" : MCP2515_TXRTS_PINS_DIG_IN
}

canBus.init(canOpts);
```

### setOpMode(*mode*) ###

#### Operation Modes ####

MCP2515_OP_MODE_NORMAL
MCP2515_OP_MODE_SLEEP
MCP2515_OP_MODE_LOOPBACK
MCP2515_OP_MODE_LISTEN_ONLY
MCP2515_OP_MODE_CONFIG
MCP2515_OP_MODE_POWERUP

<!-- ### enableOneShotMode(*enable*) -->

### reset() ###

This method triggers a SPI reset. This is functionally equivalent to a harware reset. It is important to reset after power-up to ensure that the logic and registers are in their default state. The init method will trigger a reset before configuring options. After reset the MCP2515 will automatically be set to *Configuration Mode*.

#### Return Value ####

Nothing.

#### Example ####

```
canBus.reset();
```

### configureInterrupts(*settings*)

#### Interrupt Settings ####

MCP2515_DISABLE_ALL_INTS
MCP2515_EN_INT_RXB0
MCP2515_EN_INT_RXB1
MCP2515_EN_INT_TXB0
MCP2515_EN_INT_TXB1
MCP2515_EN_INT_TXB2
MCP2515_EN_INT_ERR
MCP2515_EN_INT_WAKE
MCP2515_EN_INT_MSG_ERR

### configureRxBuffPins(*settings*)

#### RX Buffer Pin Settings ####

MCP2515_RXBF_PINS_DISABLE
MCP2515_RX0BF_PIN_EN_INT
MCP2515_RX0BF_PIN_EN_DIG_OUT_HIGH
MCP2515_RX0BF_PIN_EN_DIG_OUT_LOW
MCP2515_RX1BF_PIN_EN_INT
MCP2515_RX1BF_PIN_EN_DIG_OUT_HIGH
MCP2515_RX1BF_PIN_EN_DIG_OUT_LOW

### configureTxRtsPins(*settings*)

#### TX RTS Pin Settings ####

MCP2515_TXRTS_PINS_DIG_IN
MCP2515_TX0RTS_PIN_RTS
MCP2515_TX1RTS_PIN_RTS
MCP2515_TX2RTS_PIN_RTS

### clearFiltersAndMasks()

### enableMasksAndFilters(*enable*)

### configureMask(*maskNum, idMask*)

### configureFilter(*filterNum, ext, idFilter*)

### readMsg()

### getError()