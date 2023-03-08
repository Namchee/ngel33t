bool hasAlternatingBits(int n)
{
    bool should_one = n & 1;
    while (n)
    {
        if ((n & 1) != should_one)
        {
            return false;
        }

        n >>= 1;
        should_one = !should_one;
    }

    return true;
}