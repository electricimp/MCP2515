// The MCP2515 has three transmit and two receive
// buffers, two acceptance masks (one for each receive
// buffer) and a total of six acceptance filters. Figure 1-3
// shows a block diagram of these buffers and their
// connection to the protocol engine.

// TX Buffer addresses
const MCP2515_TX_BUFF_0_CTRL_REG  = 0x30;
const MCP2515_TX_BUFF_1_CTRL_REG  = 0x40;
const MCP2515_TX_BUFF_2_CTRL_REG  = 0x50;

const MCP2515_TX_RTS_CTRL_STAT_REG = 0x0D;

const MCP2515_TX_BUFF_0_STAND_ID_HIGH = 0x31;
const MCP2515_TX_BUFF_1_STAND_ID_HIGH = 0x41;
const MCP2515_TX_BUFF_2_STAND_ID_HIGH = 0x51;

const MCP2515_TX_BUFF_0_STAND_ID_LOW = 0x32;
const MCP2515_TX_BUFF_1_STAND_ID_LOW = 0x42;
const MCP2515_TX_BUFF_2_STAND_ID_LOW = 0x52;

const MCP2515_TX_BUFF_0_EXTEND_ID_HIGH = 0x33;
const MCP2515_TX_BUFF_1_EXTEND_ID_HIGH = 0x43;
const MCP2515_TX_BUFF_2_EXTEND_ID_HIGH = 0x53;

const MCP2515_TX_BUFF_0_EXTEND_ID_LOW = 0x34;
const MCP2515_TX_BUFF_1_EXTEND_ID_LOW = 0x44;
const MCP2515_TX_BUFF_2_EXTEND_ID_LOW = 0x54;

const MCP2515_TX_BUFF_0_DATA_LEN_CODE = 0x35;
const MCP2515_TX_BUFF_1_DATA_LEN_CODE = 0x45;
const MCP2515_TX_BUFF_2_DATA_LEN_CODE = 0x55;

const MCP2515_TX_BUFF_0_DATA_BYTE_0 = 0x36;
const MCP2515_TX_BUFF_0_DATA_BYTE_1 = 0x37;
const MCP2515_TX_BUFF_0_DATA_BYTE_2 = 0x38;
const MCP2515_TX_BUFF_0_DATA_BYTE_3 = 0x39;
const MCP2515_TX_BUFF_0_DATA_BYTE_4 = 0x3A;
const MCP2515_TX_BUFF_0_DATA_BYTE_5 = 0x3B;
const MCP2515_TX_BUFF_0_DATA_BYTE_6 = 0x3C;
const MCP2515_TX_BUFF_0_DATA_BYTE_7 = 0x3D;

const MCP2515_TX_BUFF_1_DATA_BYTE_0 = 0x46;
const MCP2515_TX_BUFF_1_DATA_BYTE_1 = 0x47;
const MCP2515_TX_BUFF_1_DATA_BYTE_2 = 0x48;
const MCP2515_TX_BUFF_1_DATA_BYTE_3 = 0x49;
const MCP2515_TX_BUFF_1_DATA_BYTE_4 = 0x4A;
const MCP2515_TX_BUFF_1_DATA_BYTE_5 = 0x4B;
const MCP2515_TX_BUFF_1_DATA_BYTE_6 = 0x4C;
const MCP2515_TX_BUFF_1_DATA_BYTE_7 = 0x4D;

const MCP2515_TX_BUFF_2_DATA_BYTE_0 = 0x56;
const MCP2515_TX_BUFF_2_DATA_BYTE_1 = 0x57;
const MCP2515_TX_BUFF_2_DATA_BYTE_2 = 0x58;
const MCP2515_TX_BUFF_2_DATA_BYTE_3 = 0x59;
const MCP2515_TX_BUFF_2_DATA_BYTE_4 = 0x5A;
const MCP2515_TX_BUFF_2_DATA_BYTE_5 = 0x5B;
const MCP2515_TX_BUFF_2_DATA_BYTE_6 = 0x5C;
const MCP2515_TX_BUFF_2_DATA_BYTE_7 = 0x5D;

const MCP2515_RX_BUFF_0_CTRL_REG = 0x60; // used
const MCP2515_RX_BUFF_1_CTRL_REG = 0x70; // used

const MCP2515_RX_BUFF_CTRL_STAT_REG = 0x0C; // used

// const MCP2515_RX_BUFF_0_STAND_ID_HIGH = 0x61; // not used
// const MCP2515_RX_BUFF_1_STAND_ID_HIGH = 0x71; // not used

// const MCP2515_RX_BUFF_0_STAND_ID_LOW = 0x62; // not used
// const MCP2515_RX_BUFF_1_STAND_ID_LOW = 0x72; // not used

// const MCP2515_RX_BUFF_0_EXTEND_ID_HIGH = 0x63; // not used
// const MCP2515_RX_BUFF_1_EXTEND_ID_HIGH = 0x73; // not used

// const MCP2515_RX_BUFF_0_EXTEND_ID_LOW = 0x64; // not used
// const MCP2515_RX_BUFF_1_EXTEND_ID_LOW = 0x74; // not used

// const MCP2515_RX_BUFF_0_DATA_LEN_CODE = 0x65; // not used
// const MCP2515_RX_BUFF_1_DATA_LEN_CODE = 0x75; // not used

// const MCP2515_RX_BUFF_0_DATA_BYTE_0 = 0x66; // not used
// const MCP2515_RX_BUFF_0_DATA_BYTE_1 = 0x67; // not used
// const MCP2515_RX_BUFF_0_DATA_BYTE_2 = 0x68; // not used
// const MCP2515_RX_BUFF_0_DATA_BYTE_3 = 0x69; // not used
// const MCP2515_RX_BUFF_0_DATA_BYTE_4 = 0x6A; // not used
// const MCP2515_RX_BUFF_0_DATA_BYTE_5 = 0x6B; // not used
// const MCP2515_RX_BUFF_0_DATA_BYTE_6 = 0x6C; // not used
// const MCP2515_RX_BUFF_0_DATA_BYTE_7 = 0x6D; // not used

// const MCP2515_RX_BUFF_1_DATA_BYTE_0 = 0x76; // not used
// const MCP2515_RX_BUFF_1_DATA_BYTE_1 = 0x77; // not used
// const MCP2515_RX_BUFF_1_DATA_BYTE_2 = 0x78; // not used
// const MCP2515_RX_BUFF_1_DATA_BYTE_3 = 0x79; // not used
// const MCP2515_RX_BUFF_1_DATA_BYTE_4 = 0x7A; // not used
// const MCP2515_RX_BUFF_1_DATA_BYTE_5 = 0x7B; // not used
// const MCP2515_RX_BUFF_1_DATA_BYTE_6 = 0x7C; // not used
// const MCP2515_RX_BUFF_1_DATA_BYTE_7 = 0x7D; // not used

const MCP2515_RX_FILTER_0_STAND_ID_HIGH = 0x00; // used
const MCP2515_RX_FILTER_1_STAND_ID_HIGH = 0x04; // used
const MCP2515_RX_FILTER_2_STAND_ID_HIGH = 0x08; // used
const MCP2515_RX_FILTER_3_STAND_ID_HIGH = 0x10; // used
const MCP2515_RX_FILTER_4_STAND_ID_HIGH = 0x14; // used
const MCP2515_RX_FILTER_5_STAND_ID_HIGH = 0x18; // used

// const MCP2515_RX_FILTER_0_STAND_ID_LOW = 0x01; // not used
// const MCP2515_RX_FILTER_1_STAND_ID_LOW = 0x05; // not used
// const MCP2515_RX_FILTER_2_STAND_ID_LOW = 0x09; // not used
// const MCP2515_RX_FILTER_3_STAND_ID_LOW = 0x11; // not used
// const MCP2515_RX_FILTER_4_STAND_ID_LOW = 0x15; // not used
// const MCP2515_RX_FILTER_5_STAND_ID_LOW = 0x19; // not used

// const MCP2515_RX_FILTER_0_EXTEND_ID_HIGH = 0x02; // not used
// const MCP2515_RX_FILTER_1_EXTEND_ID_HIGH = 0x06; // not used
// const MCP2515_RX_FILTER_2_EXTEND_ID_HIGH = 0x0A; // not used
// const MCP2515_RX_FILTER_3_EXTEND_ID_HIGH = 0x12; // not used
// const MCP2515_RX_FILTER_4_EXTEND_ID_HIGH = 0x16; // not used
// const MCP2515_RX_FILTER_5_EXTEND_ID_HIGH = 0x1A; // not used

// const MCP2515_RX_FILTER_0_EXTEND_ID_LOW = 0x03; // not used
// const MCP2515_RX_FILTER_1_EXTEND_ID_LOW = 0x07; // not used
// const MCP2515_RX_FILTER_2_EXTEND_ID_LOW = 0x0B; // not used
// const MCP2515_RX_FILTER_3_EXTEND_ID_LOW = 0x13; // not used
// const MCP2515_RX_FILTER_4_EXTEND_ID_LOW = 0x17; // not used
// const MCP2515_RX_FILTER_5_EXTEND_ID_LOW = 0x1B; // not used

const MCP2515_RX_MASK_0_STAND_ID_HIGH = 0x20; // used
const MCP2515_RX_MASK_1_STAND_ID_HIGH = 0x24; // used

// const MCP2515_RX_MASK_0_STAND_ID_LOW = 0x21; // not used
// const MCP2515_RX_MASK_1_STAND_ID_LOW = 0x25; // not used

// const MCP2515_RX_MASK_0_EXTEND_ID_HIGH = 0x22; // not used
// const MCP2515_RX_MASK_1_EXTEND_ID_HIGH = 0x26; // not used

// const MCP2515_RX_MASK_0_EXTEND_ID_LOW = 0x23; // not used
// const MCP2515_RX_MASK_1_EXTEND_ID_LOW = 0x27; // not used

const MCP2515_CONFIG_REG_1 = 0x2A; // used
const MCP2515_CONFIG_REG_2 = 0x29; // used
const MCP2515_CONFIG_REG_3 = 0x28; // used

const MCP2515_TX_ERROR_COUNT_REG = 0x1C;
const MCP2515_RX_ERROR_COUNT_REG = 0x1D;
const MCP2515_ERROR_FLAG_REG     = 0x2D; // used

const MCP2515_CAN_INT_EN_REG   = 0x2B; // used
const MCP2515_CAN_INT_FLAG_REG = 0x2C; // used

const MCP2515_CAN_CTRL_REG   = 0x0F; // used
const MCP2515_CAN_STATUS_REG = 0x0E; // used


// SPI Instructions
const MCP2515_CMD_RESET          = 0xC0;
const MCP2515_CMD_READ           = 0x03;
const MCP2515_CMD_WRITE          = 0x02;
const MCP2515_CMD_READ_STATUS    = 0xA0;
const MCP2515_CMD_RX_STATUS      = 0xB0; //
const MCP2515_CMD_BIT_MODIFY     = 0x05;
// const MCP2515_CMD_READ_RX_BUFF_0 = 0x90;
// const MCP2515_CMD_READ_RX_BUFF_1 = 0x94;
// const MCP2515_CMD_LOAD_TX_BUFF_0 = 0x40;
// const MCP2515_CMD_LOAD_TX_BUFF_1 = 0x42;
// const MCP2515_CMD_LOAD_TX_BUFF_2 = 0x44;
const MCP2515_CMD_RTS_TX_0       = 0x81;
const MCP2515_CMD_RTS_TX_1       = 0x82;
const MCP2515_CMD_RTS_TX_2       = 0x84;
const MCP2515_CMD_RTS_TX_ALL     = 0x87;

// Modes of Operation
const MCP2515_OP_MODE_MASK        = 0xE0;
const MCP2515_OP_MODE_NORMAL      = 0x00;
const MCP2515_OP_MODE_SLEEP       = 0x20;
const MCP2515_OP_MODE_LOOPBACK    = 0x40;
const MCP2515_OP_MODE_LISTEN_ONLY = 0x60;
const MCP2515_OP_MODE_CONFIG      = 0x80;
const MCP2515_OP_MODE_POWERUP     = 0xE0;

// Defualt timing settings (10Mhz clock, 1Mbit speed)
const MCP2515_INIT_DEFAULT_BRP         = 1;
const MCP2515_INIT_DEFAULT_PROP_SEG    = 1;
const MCP2515_INIT_DEFAULT_PHASE_SEG_1 = 1;
const MCP2515_INIT_DEFAULT_PHASE_SEG_2 = 1;
const MCP2515_INIT_DEFAULT_SJW         = 1;

// Settings
const MCP2515_SAM_1X         = 0x00;
const MCP2515_SAM_3X         = 0x40;

// Interrupt settings
const MCP2515_DISABLE_ALL_INTS = 0x00;
const MCP2515_EN_INT_RXB0      = 0x01;
const MCP2515_EN_INT_RXB1      = 0x02;
const MCP2515_EN_INT_TXB0      = 0x04;
const MCP2515_EN_INT_TXB1      = 0x08;
const MCP2515_EN_INT_TXB2      = 0x10;
const MCP2515_EN_INT_ERR       = 0x20;
const MCP2515_EN_INT_WAKE      = 0x40;
const MCP2515_EN_INT_MSG_ERR   = 0x80;

// RX Pin settings
const MCP2515_RXBF_PINS_DISABLE         = 0x00;
const MCP2515_RX0BF_PIN_EN_INT          = 0x05;
const MCP2515_RX0BF_PIN_EN_DIG_OUT_HIGH = 0x14;
const MCP2515_RX0BF_PIN_EN_DIG_OUT_LOW  = 0x04;
const MCP2515_RX1BF_PIN_EN_INT          = 0x0A;
const MCP2515_RX1BF_PIN_EN_DIG_OUT_HIGH = 0x18;
const MCP2515_RX1BF_PIN_EN_DIG_OUT_LOW  = 0x08;

// TX Pin settings
const MCP2515_TXRTS_PINS_DIG_IN = 0x00;
const MCP2515_TX0RTS_PIN_RTS    = 0x01;
const MCP2515_TX1RTS_PIN_RTS    = 0x02;
const MCP2515_TX2RTS_PIN_RTS    = 0x04;

class MCP2515 {

    _spi = null;
    _cs  = null;

    // Takes a configured spi and the chip select pin
    constructor(spi, cs = null) {
        _spi = spi;    // spiBCAD on FB gateway
        _cs  = cs;     // pinD on FB gateway

        if (_cs != null) _cs.configure(DIGITAL_OUT, 1);
    }

    // Reinitializes the internal registers
    // After reset MCP2515 will be in config op mode
    // Sending reset cmd is the same as using the reset pin
    // Recommended to call reset during power-on/init seq.
    function reset() {
        local data = blob(1);
        data.writen(MCP2515_CMD_RESET, 'b');

        (_cs) ? _cs.write(0) : _spi.chipselect(1);
        _spi.writeread(data);
        (_cs) ? _cs.write(1) : _spi.chipselect(0);

        imp.sleep(0.1);
    }

    // Declare controller initialization parameters
    // enMaskFilt - sets the RX buffer id mode
    // Baud rate preScaler, prop seg, phase seg 1, phase seg 2 (min val is 2), SJW (default 1)
    function init(opts = {}) {
        // Reset to default state
        reset();

        // Set chip into config mode (shouldn't be needed based on datasheet reset info)
        local res = _getReg(MCP2515_CAN_STATUS_REG);
        if ((res[0] & MCP2515_OP_MODE_MASK) != MCP2515_OP_MODE_CONFIG) setOpMode(MCP2515_OP_MODE_CONFIG);

        // Get settings from options passed in or set defaults
        local enMaskFilt   = ("enFiltering" in opts) ? opts.enFiltering : false;
        local opMode       = ("opMode" in opts) ? opts.opMode : MCP2515_OP_MODE_LOOPBACK;
        local brp          = ("baudRatePre" in opts) ? opts.baudRatePre : MCP2515_INIT_DEFAULT_BRP;
        local propSeg      = ("propSeg" in opts) ? opts.propSeg : MCP2515_INIT_DEFAULT_PROP_SEG;
        local phaseSeg1    = ("phaseSeg1" in opts) ? opts.phaseSeg1 : MCP2515_INIT_DEFAULT_PHASE_SEG_1;
        local phaseSeg2    = ("phaseSeg2" in opts) ? opts.phaseSeg2 : MCP2515_INIT_DEFAULT_PHASE_SEG_2;
        local sjw          = ("sjw" in opts) ? opts.sjw : MCP2515_INIT_DEFAULT_SJW;
        local sam          = ("samConfig" in opts) ? opts.samConfig : MCP2515_SAM_3X;
        local bltMode      = 0x80; // CONFIG 2 Register setting not exposed to user
        local sof          = ("enSOF" in opts && opts.enSOF) ? 0x80 : 0x00;
        local enWakeFilter = ("enWakeFilter" in opts && opts.enWakeFilter) ? 0x40 : 0x00
        local intSettings  = ("intConfig" in opts) ? opts.intConfig : MCP2515_DISABLE_ALL_INTS;
        local rxPins       = ("configRxPins" in opts) ? opts.configRxPins : MCP2515_RXBF_PINS_DISABLE;
        local txPins       = ("configTxPins" in opts) ? opts.configTxPins : MCP2515_TXRTS_PINS_DIG_IN;

        // Set Configuration filters
        // Note: Register values are one less than the actual values for BRP, propSeg,
        // phaseSeg1, phaseSeg2, and SJW

        // MCP2515_CONFIG_REG_1 - SJW - 1 = (6-7), BRP - 1 = (5-0)
        local val = (sjw - 1) << 6 | (brp - 1);
        _writeReg(MCP2515_CONFIG_REG_1, val);

        // MCP2515_CONFIG_REG_2 - BTLMODE(7) = 1, SAM(6) = 1, Phase1Seg - 1 (3-5), PropSeg - 1 (0-2)
        val = bltMode | sam | (phaseSeg1 - 1) << 3 | propSeg - 1;
        _writeReg(MCP2515_CONFIG_REG_2, val);

        // MCP2515_CONFIG_REG_3 - SOF(7) = 1, WAKFIL(6) = 0, NA(5-3) = 0, Phase2Seg - 1 (0-2)
        val = sof | enWakeFilter | (phaseSeg2 - 1);
        _writeReg(MCP2515_CONFIG_REG_3, val);

        // Initialize Buffers, Masks and Filters (set all filter and mask reg to 0x00)
        clearFiltersAndMasks();

        // Clear TX Control and Buffers (30 40 50 60 70)
        val = _createZeroFilledBlob(13);
        _writeReg(MCP2515_TX_BUFF_0_CTRL_REG, val);
        _writeReg(MCP2515_TX_BUFF_1_CTRL_REG, val);
        _writeReg(MCP2515_TX_BUFF_2_CTRL_REG, val);

        // Clear RX Ctrl
        _writeReg(MCP2515_RX_BUFF_0_CTRL_REG, 0x00);
        _writeReg(MCP2515_RX_BUFF_1_CTRL_REG, 0x00);

        // Configure Interrupts
        configureInterrupts(intSettings);
        // Configure RX Pins
        configureRxBuffPins(rxPins);
        // Configure TX RTS Pins
        configureTxRtsPins(txPins);

        // Enable msg filtering
        enableMasksAndFilters(enMaskFilt);

        // Set Can Control Mode
        setOpMode(opMode);
    }

    function setOpMode(mode) {
        local res = _modifyReg(MCP2515_CAN_CTRL_REG, MCP2515_OP_MODE_MASK, mode);
        return _getReg(MCP2515_CAN_STATUS_REG)[0] & MCP2515_OP_MODE_MASK;
    }

    function configureInterrupts(settings) {
        _writeReg(MCP2515_CAN_INT_EN_REG, settings);
    }

    function configureRxBuffPins(settings) {
        _writeReg(MCP2515_RX_BUFF_CTRL_STAT_REG, settings);
    }

    function configureTxRtsPins(settings) {
        _writeReg(MCP2515_TX_RTS_CTRL_STAT_REG, settings);
    }

    function clearFiltersAndMasks() {
        val = _createZeroFilledBlob(12);
        _writeReg(MCP2515_RX_FILTER_0_STAND_ID_HIGH, val);
        _writeReg(MCP2515_RX_FILTER_3_STAND_ID_HIGH, val);

        val = _createZeroFilledBlob(8);
        _writeReg(MCP2515_RX_MASK_0_STAND_ID_HIGH, val);
    }

    function enableMasksAndFilters(enable) {
        if (enable) {
            _modifyReg(MCP2515_RX_BUFF_0_CTRL_REG, 0x64, 0x00);
            _modifyReg(MCP2515_RX_BUFF_1_CTRL_REG, 0x60, 0x00);
        } else {
            _modifyReg(MCP2515_RX_BUFF_0_CTRL_REG, 0x64, 0x60);
            _modifyReg(MCP2515_RX_BUFF_1_CTRL_REG, 0x60, 0x60);
        }
    }

    // NOTE: Mask 0 - is mask for buffer 0, mask 1 is mask for buffer 1
    function configureMask(maskNum, ext, id) {
        switch (maskNum) {
            case 0:
                _configureMasksAndFilters(MCP2515_RX_MASK_0_STAND_ID_HIGH, ext, id);
                break;
            case 1:
                _configureMasksAndFilters(MCP2515_RX_MASK_1_STAND_ID_HIGH, ext, id);
                break;
            default:
                // Invalid mask number
                break;
        }
    }

    // NOTE: Filters 0 & 1 filter buffer 0, filters 2 - 5 filter buffer 1
    function configureFilter(filterNum, ext, id) {
        switch (filterNum) {
            case 0:
                _configureMasksAndFilters(MCP2515_RX_FILTER_0_STAND_ID_HIGH, ext, id);
                break;
            case 1:
                _configureMasksAndFilters(MCP2515_RX_FILTER_1_STAND_ID_HIGH, ext, id);
                break;
            case 2:
                _configureMasksAndFilters(MCP2515_RX_FILTER_2_STAND_ID_HIGH, ext, id);
                break;
            case 3:
                _configureMasksAndFilters(MCP2515_RX_FILTER_3_STAND_ID_HIGH, ext, id);
                break;
            case 4:
                _configureMasksAndFilters(MCP2515_RX_FILTER_4_STAND_ID_HIGH, ext, id);
                break;
            case 5:
                _configureMasksAndFilters(MCP2515_RX_FILTER_5_STAND_ID_HIGH, ext, id);
                break;
            default:
                // Invalid filter number
                break;
        }
    }

    function readMsg() {
        // Check for msgs in buffer 0 and 1
        local status = _readStatus();
        // server.log(format("0x%02X", status));

        local msg = null;
        if (status & 0x01) {
            // server.log("We have msg in buffer 0");
            // get message, clear interrupt flag
            msg = _readMsgFromBuffer(MCP2515_RX_BUFF_0_CTRL_REG);
            _modifyReg(MCP2515_CAN_INT_FLAG_REG, 0x01, 0x00);
        } else if (status & 0x02) {
            // server.log("We have msg in buffer 1");
            // get message, clear interrupt flag
            msg = _readMsgFromBuffer(MCP2515_RX_BUFF_1_CTRL_REG);
            _modifyReg(MCP2515_CAN_INT_FLAG_REG, 0x02, 0x00);
        } else {
            // server.log("No msg found.");
        }

        return msg;
    }

    function getError() {
        local res = _getReg(MCP2515_ERROR_FLAG_REG);
        local errors = {};
        if (typeof res == "blob" && res.len() == 1) {
            local errorFlagReg = res[0];
            errors.errorFound <- (errorFlagReg != 0);                 // server.log("Errors found");
            errors.rxB1Overflow <- (errorFlagReg & 0x01);       // server.log("RX Buffer 1 overflow");
            errors.rxB0Overflow <- (errorFlagReg & 0x02);       // server.log("RX Buffer 0 overflow");
            errors.txBusOff <- (errorFlagReg & 0x04);           // server.log("TX Bus off");
            errors.txErrorPassive <- (errorFlagReg & 0x08);     // server.log("TX Error Passive");
            errors.rxErrorPassive <- (errorFlagReg & 0x10);     // server.log("RX Error Passive");
            errors.txErrorWarning <- (errorFlagReg & 0x20);     // server.log("TX Error Warning");
            errors.rxErrorWarning <- (errorFlagReg & 0x40);     // server.log("RX Error Warning");
            errors.txRxErrorWarning <- (errorFlagReg & 0x80);   // server.log("TX or RX Error Warning");
        }
        return errors;
    }

    function _configureMasksAndFilters(startingAddr, ext, id) {
        local data = blob(4);
        // 0 = Standard High reg data (bits 3-10 of standard id)
        // 1 = Standard Low reg data (bits 0-2 of standard id, ext filter enable, and bits 16-17 ext id)
        // 2 = Extened High reg data (bits 8-15 of ext id)
        // 3 = Extended Low reg data (bits 0-7 of ext id)

        // Note: Each filter/mask id will be written to both the standard and
        // extened registers, unkown bits will be set to 0 (no mask/filter)

        // 0 | 0000 | 0000 | 0000 | 0000 | 0 ** 000 | 0000 | 0000 |

        //                               | 0 ** 111 | 1111 | 1000 |
        //                                                 | 0111 |

        // 0 | 0000 | 0000 | 0000 | 0000 | 0 ** 000 | 0000 | 0000 |
        //   | 0111 | 1111 | 1000 | 0000 | 0 ** 000 | 0000 | 0000 |
        //                 | 0111 | 1111 | 1 ** 000 | 0000 | 0000 |
        // 1 | 1000 | 0000 | 0000 | 0000 | 0 ** 000 | 0000 | 0000 |

        // Top bits of Standard id (grab bits 3-10 of id)
        data[0] = (id & 0x7F8) >> 3;
        // Mid bits of Extended id (grab bits 8-15 of id)
        data[2] = (id & 0x7F80000) >> 19;
        // Lower bits of Extended id (grab bits 0-7 of id)
        data[3] = id & 0x7F800 >> 11;

        // If ext filter enabled write 1 to reg bit 3
        local extEn = (ext) ? 1 : 0;
        // Lower bits stand (grab 0-2 of id) write to reg bits 5-7,
        // Top bits Ext (grab 16-17 of id) write to reg bits 0-1,
        data[1] = (id & 0x07) << 5 | extEn << 3 | (id << 27) & 0x03;

        // Set to configure mode
        local mode = _getReg(MCP2515_CAN_STATUS_REG)[0] & MCP2515_OP_MODE_MASK;
        local res = setOpMode(MCP2515_OP_MODE_CONFIG);

        // Update register
        res = _writeReg(startingAddr, data);

        // Set back to non-config mode
        res = setOpMode(mode);
    }

    function _readMsgFromBuffer(buffCtrlAddr) {
        local res = _getReg(buffCtrlAddr, 6);
        // server.log("Get readMsg response: ");
        // server.log(res);
        // [0] - CTRL, [1] - StandId high, [2] - StandId low
        // [3] - ExtId high, [4] - ExtId low, [5] - Data len

        // 0x-0 - (3) remote transfer requested
        // 0x-1 - stand id high (3-10)
        // 0x-2 - (0-1) ext id MSB (16-17),
        //        (3) extend flag ext = 1, stand = 0,
        //        (4) stand frame remote=1,
        //        (5-7) stand id (0-2)
        // 0x-3 - extended id high (8-15)
        // 0x-4 - extended id low (0-7)
        // 0x-5 - (0-3) data length,
        //        (6) extended frame remote=1,

        local rtr;
        local ext = (res[2] & 0x08) == 1;
        local dataLen = res[5] & 0x0F;
        // Grab the Standard ID
        local id = res[1] << 3 | (res[2] & 0xE0) >> 5
        // Remote transfer request received
        local rtrReceived = (res[0] & 0x08) == 1;
        if (ext) {
            // We have an extended frame msg
            // Remote transmit requested
            rtr = (res[5] & 0x40) == 1;
            // Update msg ID to include extended ID
            id = (res[2] & 0x03) << 27 | res[3] << 19 | res[4] << 11 | id;
        } else {
            // We have a standard frame msg, check remote transmit request
            rtr = (res[2] & 0x10) == 1;
        }

        // Read data out of buffer
        local data = _getReg(buffCtrlAddr + 6, dataLen);
        return {"extended" : ext, "rtr" : rtr, "rtrReceived" : rtrReceived, "id" : id, "data" : data};
    }

    function _writeReg(addr, val) {
        local data = blob();
        data.writen(MCP2515_CMD_WRITE, 'b');
        data.writen(addr, 'b');
        if (typeof val == "blob") {
            data.writeblob(val);
        } else {
            data.writen(val, 'b');
        }

        (_cs) ? _cs.write(0) : _spi.chipselect(1);
        local res = _spi.writeread(data);
        (_cs) ? _cs.write(1) : _spi.chipselect(0);

        return res;
    }

    function _getReg(addr, numBytes = 1) {
        local data = blob();
        data.writen(MCP2515_CMD_READ, 'b');
        data.writen(addr, 'b');
        for (local i = 0; i < numBytes; i++) {
            data.writen(0x00, 'b');
        }

        (_cs) ? _cs.write(0) : _spi.chipselect(1);
        local res = _spi.writeread(data);
        (_cs) ? _cs.write(1) : _spi.chipselect(0);

        res.seek(2, 'b');
        return (numBytes > 0) ? res.readblob(numBytes) : null;
    }

    function _modifyReg(addr, mask, val) {
        local data = blob(4);
        data.writen(MCP2515_CMD_BIT_MODIFY, 'b');
        data.writen(addr, 'b');
        data.writen(mask, 'b');
        data.writen(val, 'b');

        (_cs) ? _cs.write(0) : _spi.chipselect(1);
        local res = _spi.writeread(data);
        (_cs) ? _cs.write(1) : _spi.chipselect(0);

        return res;
    }

    function _readStatus() {
        local data = blob();
        data.writen(MCP2515_CMD_READ_STATUS, 'b');
        data.writen(0xFF, 'b');

        (_cs) ? _cs.write(0) : _spi.chipselect(1);
        local res = _spi.writeread(data);
        (_cs) ? _cs.write(1) : _spi.chipselect(0);

        return res[1];
    }

    function _createZeroFilledBlob(length) {
        local b = blob(length);
        for (local i = 0; i < b.len(); i++) {
            b.writen(0x00, 'b');
        }
        return b;
    }
}

