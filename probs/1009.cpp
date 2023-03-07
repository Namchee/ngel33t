int bitwiseComplement(int n)
{
    if (!n)
    {
        return 1;
    }
    int msb = getMSBPosition(n);
    int result = 0;
    while (msb--)
    {
        int bit = n & (1 << msb);
        if (!bit)
        {
            result += (1 << msb);
        }
    }

    return result;
}

int getMSBPosition(int n)
{
    int count = 0;
    while (n)
    {
        count++;
        n >>= 1;
    }
    return count;
}
