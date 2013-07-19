<?php
/**
  * 主要功能：类似于Awk，如果想处理一个文件中的每一行，利用这个基础类可以只用关注行内部的处理，打开文件，关闭文件，循环处理文件的每一行都由基础类完成了
  *
  */
class AwkBase {

	// properties
/*
	private static $connector = null;

	private $table_name = 'RelatedSearch';
	private $is_auto_increment = true;
	private static $primary_key_list = array( 'id' );
*/
    private $file = '';
	public function __construct($seedFile) {
        $this->file = $seedFile;
    }

    public function processFile() {
        $handle = fopen($this->file, "r+");
        $lineNum = 0;
        while (($buffer = fgets($handle)) !== false) {
            $buffer = trim($buffer);
            ++$lineNum;
            $this->processLine($buffer, $lineNum);
        }
    }
    public function processLine($lineStr) {
        echo $lineStr."\n";
    }

}

