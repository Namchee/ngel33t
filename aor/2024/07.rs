pub struct LogQuery<'a> {
    logs: &'a Vec<String>,
}

impl<'a> LogQuery<'a> {
    pub fn new(logs: &'a Vec<String>) -> LogQuery {
        LogQuery{
            logs
        }
    }

    pub fn search(&self, query: &str) -> Vec<&'a String> {
        self.logs.iter().filter(|log| log.contains(query)).collect()
    }
}
