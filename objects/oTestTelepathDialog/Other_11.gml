playerControlLock();
_updateDialogBoxDimentions();
drawSpriteSetSize(sTestTranscendedBeastFace, 0, dbCenter, global.windowBottom / 3.5, 64, 64);

switch (sequenceIndex)
{
    case "name call":
        if (_sequenceInitialize())
        {
            _nextText(endText[UnknownEnum.Value_0]);
            _typeInStart();
        }
        
        _drawTextBox();
        _drawText();
        _drawProceedSign();
        _clickToSkipOrClearText();
        
        if (typist.get_state() >= 2)
            _nextSequence("thanks");
        
        break;
    
    case "thanks":
        if (_sequenceInitialize())
        {
            _nextText(endText[UnknownEnum.Value_1]);
            _typeInStart();
        }
        
        _drawTextBox();
        _drawText();
        _drawProceedSign();
        _clickToSkipOrClearText();
        
        if (typist.get_state() >= 2)
            _nextSequence("revelation 1");
        
        break;
    
    case "revelation 1":
        if (_sequenceInitialize())
        {
            _nextText(endText[UnknownEnum.Value_2]);
            _typeInStart();
        }
        
        _drawTextBox();
        _drawText();
        _drawProceedSign();
        _clickToSkipOrClearText();
        
        if (typist.get_state() >= 2)
            _nextSequence("revelation 2");
        
        break;
    
    case "revelation 2":
        if (_sequenceInitialize())
        {
            _nextText(endText[UnknownEnum.Value_3]);
            _typeInStart();
        }
        
        _drawTextBox();
        _drawText();
        _drawProceedSign();
        _clickToSkipOrClearText();
        
        if (typist.get_state() >= 2)
            _nextSequence("love");
        
        break;
    
    case "love":
        if (_sequenceInitialize())
        {
            _nextText(endText[UnknownEnum.Value_4]);
            _typeInStart();
        }
        
        _drawTextBox();
        _drawText();
        _drawProceedSign();
        _clickToSkipOrClearText();
        
        if (typist.get_state() >= 2)
            _nextSequence("silence");
        
        break;
    
    case "silence":
        if (_sequenceInitialize())
        {
            _nextText(endText[UnknownEnum.Value_5]);
            _typeInStart();
        }
        
        _drawTextBox();
        _drawText();
        _drawProceedSign();
        _clickToSkipOrClearText();
        
        if (typist.get_state() >= 2)
            _nextSequence("aa");
        
        break;
    
    case "aa":
        if (_sequenceInitialize())
        {
            _nextText(endText[UnknownEnum.Value_6]);
            _typeInStart();
        }
        
        _drawTextBox();
        _drawText();
        _drawProceedSign();
        _clickToSkipOrClearText();
        
        if (typist.get_state() >= 2)
            _nextSequence("bb");
        
        break;
    
    case "bb":
        if (_sequenceInitialize())
        {
            _nextText(endText[UnknownEnum.Value_7]);
            _typeInStart();
        }
        
        _drawTextBox();
        _drawText();
        _drawProceedSign();
        _clickToSkipOrClearText();
        
        if (typist.get_state() >= 2)
            _nextSequence("cc");
        
        break;
    
    case "cc":
        if (_sequenceInitialize())
        {
            _nextText(endText[UnknownEnum.Value_8]);
            _typeInStart();
        }
        
        _drawTextBox();
        _drawText();
        _drawProceedSign();
        _clickToSkipOrClearText();
        
        if (typist.get_state() >= 2)
            _nextSequence("dd");
        
        break;
    
    case "dd":
        if (_sequenceInitialize())
        {
            _nextText(endText[UnknownEnum.Value_9]);
            _typeInStart();
        }
        
        _drawTextBox();
        _drawText();
        _drawProceedSign();
        _clickToSkipOrClearText();
        
        if (typist.get_state() >= 2)
            _nextSequence("ff");
        
        break;
    
    case "ff":
        if (_sequenceInitialize())
        {
            _nextText(endText[UnknownEnum.Value_10]);
            _typeInStart();
        }
        
        _drawTextBox();
        _drawText();
        _drawProceedSign();
        _clickToSkipOrClearText();
        
        if (typist.get_state() >= 2)
            _nextSequence("ee");
        
        break;
    
    case "ee":
        if (_sequenceInitialize())
        {
            _nextText(endText[UnknownEnum.Value_11]);
            _typeInStart();
        }
        
        _drawTextBox();
        _drawText();
        _drawProceedSign();
        _clickToSkipOrClearText();
        
        if (typist.get_state() >= 2)
            _nextSequence(" ");
        
        break;
}
