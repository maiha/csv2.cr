require "./spec_helper"

describe CSV2 do
  describe "build" do
    it "builds two rows" do
      string = CSV2.build do |csv|
        csv.row do |row|
          row << "one"
          row << "two"
        end
        csv.row do |row|
          row << "three"
          row << "four"
        end
      end
      string.should eq("one,two\nthree,four\n")
    end

    it "builds with numbers" do
      string = CSV2.build do |csv|
        csv.row do |row|
          row << 1
          row << 2
        end
        csv.row do |row|
          row << 3
          row << 4
        end
      end
      string.should eq("1,2\n3,4\n")
    end

    it "builds with commas" do
      string = CSV2.build do |csv|
        csv.row do |row|
          row << %(hello,world)
        end
      end
      string.should eq(%("hello,world"\n))
    end

    it "builds with custom separator" do
      string = CSV2.build(separator: ';') do |csv|
        csv.row do |row|
          row << "one"
          row << "two"
          row << "thr;ee"
        end
      end
      string.should eq(%(one;two;"thr;ee"\n))
    end

    it "builds with quotes" do
      string = CSV2.build do |csv|
        csv.row do |row|
          row << %(he said "no")
        end
      end
      string.should eq(%("he said ""no"""\n))
    end

    it "builds with custom quote character" do
      string = CSV2.build(quote_char: '\'') do |csv|
        csv.row do |row|
          row << %(he said 'no')
        end
      end
      string.should eq(%('he said ''no'''\n))
    end

    it "builds row from enumerable" do
      string = CSV2.build do |csv|
        csv.row [1, 2, 3]
      end
      string.should eq("1,2,3\n")
    end

    it "builds row from splat" do
      string = CSV2.build do |csv|
        csv.row 1, 2, 3
      end
      string.should eq("1,2,3\n")
    end

    it "skips inside row" do
      string = CSV2.build do |csv|
        csv.row do |row|
          row << 1
          row.skip_cell
          row << 2
        end
      end
      string.should eq("1,,2\n")
    end

    it "concats enumerable to row" do
      string = CSV2.build do |csv|
        csv.row do |row|
          row << 1
          row.concat [2, 3, 4]
          row << 5
        end
      end
      string.should eq("1,2,3,4,5\n")
    end

    it "concats splat to row" do
      string = CSV2.build do |csv|
        csv.row do |row|
          row << 1
          row.concat 2, 3, 4
          row << 5
        end
      end
      string.should eq("1,2,3,4,5\n")
    end

    it "builds with commas" do
      string = CSV2.build do |csv|
        csv.row do |row|
          row << " , "
          row << " , "
        end
      end
      string.should eq(%(" , "," , "\n))
    end

    it "builds with quoting" do
      string = CSV2.build(quoting: CSV2::Builder::Quoting::NONE) do |csv|
        csv.row 1, "doesn't", " , ", %(he said "no")
      end
      string.should eq(%(1,doesn't, , ,he said "no"\n))

      string = CSV2.build(quoting: CSV2::Builder::Quoting::RFC) do |csv|
        csv.row 1, "doesn't", " , ", %(he said "no")
      end
      string.should eq(%(1,doesn't," , ","he said ""no"""\n))

      string = CSV2.build(quoting: CSV2::Builder::Quoting::ALL) do |csv|
        csv.row 1, "doesn't", " , ", %(he said "no")
      end
      string.should eq(%("1","doesn't"," , ","he said ""no"""\n))
    end
  end
end
