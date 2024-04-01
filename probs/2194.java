class Solution {
    public List<String> cellsInRange(String s) {
        String[] ranges = s.split(":");
        char startCol = ranges[0].charAt(0);
        char startRow = ranges[0].charAt(1);
        char endCol = ranges[1].charAt(0);
        char endRow = ranges[1].charAt(1);

        List<String> result = new ArrayList();

        for (int i = (int)startCol; i <= (int)endCol; i++) {
            for (int j = (int)startRow; j <= (int)endRow; j++) {
                String str = "";
                str += (char)i;
                str += (char)j;
                result.add(str);
            }
        }

        return result;
    }
}
