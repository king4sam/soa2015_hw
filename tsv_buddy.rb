# Module that can be included (mixin) to create and parse TSV data
module TsvBuddy
  # @data should be a data structure that stores information
  #  from TSV or Yaml files. For example, it could be an Array of Hashes.
  attr_accessor :data

  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    read_line = tsv.split("\n")
    output = []
    field = []
    field_name = read_line[0].split("\t")
    field_name.each { |x| field.push(x)  }

    read_line.drop(1).each{ |aline|
      temHash = Hash.new
      tuple = aline.split("\t")
      tuple.each_index{|index|
        temHash[field[index]] = tuple[index]
      }
      output.push(temHash)
    }
    @data=output
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    field = ""
    @data[0].each{|k,_|
      if field != ""
        field.concat("\t"+k)
      else field.concat(k)
      end
    }
    allstring = ''
    allstring.concat(field+"\n")
    @data.each{|tuple|
      newline = true
      tuple.each_value{|value|
        if newline == true
          allstring << value.to_s
          newline = false
        else
          allstring << "\t" + value.to_s
        end
      }
      allstring << "\n"
    }
    allstring
  end

end
