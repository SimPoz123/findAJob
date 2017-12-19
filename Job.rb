
TAX = 0.11 + 0.04 + 0.062 + 0.0145

class Job

    attr_accessor :title, :wage, :workweek, :gross, :net, :benefits, :id

    def initialize(title, wage, workweek, benefits, id)
      @title = title
      @wage = wage.delete!("$").to_f
      @workweek = workweek.to_f
      @gross = @wage * @workweek
      @net = @gross * (1 - TAX)
      if benefits == "true"
        @benefits = true
      else
        @benefits = false
      end
      @id = id.to_i
    end

    def show(count)
      if @benefits
        puts "#{count}. A #{@title} makes #{@wage} per hour, with a #{@workweek} hour work week, and has benefits. ID: #{@id}"
      else
        puts "#{count}. A #{@title} makes #{@wage} per hour, with a #{@workweek} hour work week. ID: #{@id}"
      end
    end

    def taxes(count)
      if count == 0
        puts "A #{@title} would lose $#{(@gross.to_i * TAX).to_i} to taxes every week. ID: #{@id}"
      else
        puts "#{count}. A #{@title} would lose $#{(@gross.to_i * TAX).to_i} to taxes every week. ID: #{@id}"
      end
    end

    def income(count)
      if count == 0
        puts "After taxes, a #{@title} makes $#{@net.to_i} each week, and $#{@net.to_i * 52} each year. ID: #{@id}"
      else
        puts "#{count}. After taxes, a #{@title} makes $#{@net.to_i} each week, and $#{@net.to_i * 52} each year. ID: #{@id}"
      end
    end

    def choose
      puts "\n\n\nYou have chosen the position of #{@title}"
      self.taxes(0)
      self.income(0)
    end

end
