# The CSSCompressor class compresses CSS files by removing empty lines and comments. 
class CSSCompressor
  attr_accessor :filename
 
  # User creates new object and specifies filename to be compressed.
  def initialize(filename)
    @filename = filename
  end
 
  # User performs compression and (optionally) specifies new file name 
  def compress_to (destination_filename = "compressed.css")
    oldfile = File.open(@filename, "r")
    oldcontents = ""
    # Strip white space and emptly lines
    oldfile.each_line do |line|
	line.strip!
	oldcontents << line 
	oldcontents << "\n" if line.size > 0 and !line.include? "}"
    end
    newcontents = ""
    # Break up contents by css code blocks and remove all comments
    oldcontents.split('}').each do |block|
      block.gsub!(/\/\*.*?\*\//m,'')
      newcontents << block + "}"
    end
    File.open(destination_filename, 'w') {|f| f.write(newcontents) }
  end
end
