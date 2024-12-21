use std::time::{SystemTime, UNIX_EPOCH};
use std::path::PathBuf;
use std::fs::{File, write, read_to_string, remove_file};
use std::env;

pub struct TempFile {
    file_path: PathBuf,
    file: File
}
impl TempFile {
    pub fn new() -> Result<Self, std::io::Error> {
        let base_path = PathBuf::from(env::temp_dir()).into_os_string().into_string().unwrap();
        let random = SystemTime::now().duration_since(UNIX_EPOCH).unwrap().as_nanos().to_string();

        let file_path = base_path + &random;

        Ok(
            TempFile {
                file: File::create(&file_path)?,
                file_path: file_path.into()
            }
        )
    }

    pub fn write(&self, data: &[u8]) -> Result<(), std::io::Error> {
        write(&self.file_path, data)
    }

    pub fn read_to_string(&self) -> Result<String, std::io::Error> {
        read_to_string(&self.file_path)
    }

    pub fn path(&self) -> &PathBuf {
        &self.file_path
    }
    pub fn file(&self) -> &File {
        &self.file
    }
}

impl Drop for TempFile {
    fn drop(&mut self) {
        let _ = remove_file(&self.file_path);
    }
}
