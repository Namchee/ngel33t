int main()
{
    const int dimension = 5;
    int matrix[dimension][dimension];

    for (int layer = 0; layer < dimension / 2; layer++)
    {
        int limit = dimension - layer - 1;

        for (int idx = layer; idx < limit; idx++)
        {
            int temp = matrix[layer][idx];
            matrix[layer][idx] = matrix[limit - idx][layer];
            matrix[limit - idx][layer] = matrix[limit][limit - idx];
            matrix[limit][limit - idx] = matrix[idx][limit];
            matrix[idx][limit] = temp;
        }
    }
    return 0;
}