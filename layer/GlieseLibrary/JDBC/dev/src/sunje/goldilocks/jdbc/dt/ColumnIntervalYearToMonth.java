package sunje.goldilocks.jdbc.dt;

import java.math.BigDecimal;
import java.sql.SQLException;

import sunje.goldilocks.jdbc.ex.ErrorMgr;
import sunje.goldilocks.sql.GoldilocksInterval;

public class ColumnIntervalYearToMonth extends ColumnIntervalYearMonthCommon
{
    ColumnIntervalYearToMonth(CodeColumn aCode)
    {
        super(aCode);
    }
    
    private void setYearMonth(GoldilocksInterval aInterval) throws SQLException
    {
        mMonth = aInterval.getSign() * (aInterval.getYear() * 12 + aInterval.getMonth());
    }

    protected void setByteImpl(byte aValue) throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, "byte", mCode.getTypeName());
    }

    protected void setShortImpl(short aValue) throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, "short", mCode.getTypeName());
    }

    protected void setIntImpl(int aValue) throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, "int", mCode.getTypeName());
    }

    protected void setLongImpl(long aValue) throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, "long", mCode.getTypeName());
    }

    protected void setFloatImpl(float aValue) throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, "float", mCode.getTypeName());
    }

    protected void setDoubleImpl(double aValue) throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, "double", mCode.getTypeName());
    }

    protected void setStringImpl(String aValue) throws SQLException
    {
        setYearMonth(GoldilocksInterval.createIntervalYearToMonth((int)mPrecision, aValue));
    }

    protected void setObjectImpl(Object aValue) throws SQLException
    {
        if (!(aValue instanceof GoldilocksInterval))
        {
            ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, aValue.getClass().getName(), mCode.getTypeName());
        }
        setYearMonth((GoldilocksInterval)aValue);
    }

    protected void setBigDecimalImpl(BigDecimal aValue) throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, "BigDecimal", mCode.getTypeName());
    }

    protected byte getByteImpl() throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, mCode.getTypeName(), "byte");
        return 0;
    }

    protected short getShortImpl() throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, mCode.getTypeName(), "short");
        return 0;
    }

    protected int getIntImpl() throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, mCode.getTypeName(), "int");
        return 0;
    }

    protected long getLongImpl() throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, mCode.getTypeName(), "long");
        return 0;
    }

    protected float getFloatImpl() throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, mCode.getTypeName(), "float");
        return 0;
    }

    protected double getDoubleImpl() throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, mCode.getTypeName(), "double");
        return 0;
    }

    protected String getStringImpl() throws SQLException
    {
        return GoldilocksInterval.createIntervalYearToMonth((int)mPrecision, mMonth >= 0, Math.abs(mMonth) / 12, Math.abs(mMonth) % 12).toString();
    }

    protected Object getObjectImpl() throws SQLException
    {
        return GoldilocksInterval.createIntervalYearToMonth((int)mPrecision, mMonth >= 0, Math.abs(mMonth) / 12, Math.abs(mMonth) % 12);
    }

    protected BigDecimal getBigDecimalImpl() throws SQLException
    {
        ErrorMgr.raise(ErrorMgr.TYPE_CONVERSION_ERROR, mCode.getTypeName(), "BigDecimal");
        return null;
    }
}