require './Job'
require './scan'

def findAJob()
  file = open("Jobs.csv")
  list = file.read
  list = list.split(/\n/)

  jobs = Array.new

  for i in 1...list.length
    line = list[i]
    line = line.split(',')
    jobs.push(Job.new(line[0], line[1], line[2], line[3], line[4]))
  end

  puts "\nWhat would you like to see?"
  puts "1. All Jobs"
  puts "2. All Jobs With Benefits"
  puts "3. 10 Top Paying Jobs"
  puts "4. 10 Top Paying Jobs With Benefits"
  puts "5. 10 Highest Hourly Wages"
  puts "6. 10 Highest Work Weeks"
  puts "7. How much does each job lose to taxes?"
  puts "8. Pick A Job\n\n"
  $stdout.flush
  i = scan.to_i
  if i == 1
    showAll(jobs)
  elsif i == 2
    showAllBenefits(jobs)
  elsif i == 3
    topTen(jobs)
  elsif i == 4
    topTenBenefits(jobs)
  elsif i == 5
    topWages(jobs)
  elsif i == 6
    topWeeks(jobs)
  elsif i == 7
    showTaxes(jobs)
  elsif i == 8
    pickAJob(jobs)
  else
    puts "Please us a valid input"
    findAJob()
  end

end


def showAll(jobs)
  puts "\n"

  count = 1
  jobs.each do |i|
    i.show(count)
    count = count + 1
  end

  seeAgain()
end





def showAllBenefits(jobs)
  puts "\n"

  count = 1
  jobs.each do |i|
    if i.benefits
      i.show(count)
      count = count + 1
    end
  end

  seeAgain()
end





def topTen(jobs)
  top = Array.new

  disp = jobs

  10.times do
    max = disp[0]

    disp.each do |i|
      if i.gross >= max.gross
        max = i
      end
    end

    top.push(max)
    disp.delete(max)
  end

  puts "\nThe 10 Top Paying Jobs are:"
  count = 1
  top.each do |i|
    i.income(count)
    count = count + 1
  end

  seeAgain()
end




def topTenBenefits(jobs)
  top = Array.new

  disp = jobs

  10.times do
    max = disp[0]
    count = 0

    while !max.benefits
      count = count + 1
      if disp[count].benefits
        max = disp[count]
      end
    end

    for i in count + 1...disp.length
      if disp[i].gross >= max.gross && disp[i].benefits
        max = disp[i]
      end
    end

    top.push(max)
    disp.delete(max)
  end

  puts "\nThe Ten Top Paying Jobs with Benefits are:"
  count = 1
  top.each do |i|
    i.income(count)
    count = count + 1
  end

  seeAgain()
end





def topWages(jobs)
  top = Array.new

  disp = jobs

  10.times do |i|
    max = disp[0]

    disp.each do |i|
      if i.wage >= max.wage
        max = i
      end
    end

    top.push(max)
    disp.delete(max)
  end

  puts "\nThe Ten Jobs with the Highest Wages are:"
  showAll(top)
end




def topWeeks(jobs)
  top = Array.new

  disp = jobs

  10.times do |i|
    max = disp[0]

    disp.each do |i|
      if i.workweek >= max.workweek
        max = i
      end
    end

    top.push(max)
    disp.delete(max)
  end

  puts "\nThe Ten Jobs with the Highest Work Weeks are:"
  showAll(top)
end




def showTaxes(jobs)
  count = 1
  jobs.each do |i|
    i.taxes(count)
    count = count + 1
  end

  seeAgain()

end




def pickAJob(jobs)
  puts "\n\nWould you like to..."
  puts "1. Select a job from the list"
  puts "2. Search for a job using a keyword or the ID."
  $stdout.flush
  i = scan.to_i
  if i == 1
    selectFromList(jobs)
  elsif i == 2
    search(jobs)
  else
    puts "Please use a valid input"
    pickAJob(jobs)
  end
end



def selectFromList(jobs)
  puts "Here is a list of all jobs:"
  puts "\n"

  count = 1
  jobs.each do |i|
    i.show(count)
    count = count + 1
  end

  puts "\n Which job would you like?"
  $stdout.flush
  i = scan.to_i
  jobs[i-1].choose
end

def search(jobs)
  puts "\n How would you like to search for you job?"
  puts "1. Search by Name"
  puts "2. Search by ID"
  $stdout.flush
  i = scan.to_i
  if i == 1
    searchName(jobs)
  elsif i == 2
    searchID(jobs)
  else
    puts "Please use a valid input"
    search(jobs)
  end
end

def searchName(jobs)
  puts "\n Please input a keyword for your job."
  $stdout.flush
  keyword = scan.to_s
  keyword.delete!("\n")

  results = Array.new
  jobs.each do |i|
    if i.title.downcase.include? keyword.downcase
      results.push(i)
    end
  end

  if results.length == 0
    puts "Try another keyword"
    search(jobs)
  end

  puts "\nHere are your results:"
  count = 1
  results.each do |i|
    i.show(count)
    count = count + 1
  end

  puts "\nWhich of these would you like to choose?"
  $stdout.flush
  i = scan.to_i
  if i <= results.length
    results[i-1].choose
  else
    puts "Please use a valid input"
    searchName(jobs)
  end
end

def searchID(jobs)
  puts "\nPlease input the ID of your desired job"
  $stdout.flush
  id = scan.to_i
  jobs.each do |i|
    if i.id == id
      i.choose
    end
  end
end


def seeAgain()
  puts "\n\nWould you like to see anything else?"
  $stdout.flush
  answer = scan.to_s
  answer.delete!("\n")
  if answer.downcase == "yes" || answer.downcase == "yeah" || answer.downcase == "y"
    findAJob()
  else
    puts "Thank you."
  end
end

findAJob()
