package sunje.goldilocks.jdbc.dt;

public class CodeColumnIntervalHourToMinute extends CodeColumnInterval
{
    static CodeColumnIntervalHourToMinute PROTOTYPE = new CodeColumnIntervalHourToMinute();
    
    private CodeColumnIntervalHourToMinute()
    {        
    }
    
    public byte getDataType()
    {
        return GOLDILOCKS_DATA_TYPE_INTERVAL_DAY_TO_SECOND;
    }
    
    public String getTypeName()
    {
        return GOLDILOCKS_DATA_TYPE_NAME_INTERVAL_HOUR_TO_MINUTE;
    }
    
    Column getInstance()
    {
        return new ColumnIntervalHourToMinute(PROTOTYPE);
    }

    byte getDefaultIntervalIndicator()
    {
        return INTERVAL_INDICATOR_HOUR_TO_MINUTE;
    }
}