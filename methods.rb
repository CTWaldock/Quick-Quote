# Option 1 Get Quote menu main
def quote_menu(jobs_arr, job_name = '')

    loop do 
        if job_name == ''
            puts "Jobs List:".center(50)
            puts "**************************".center(50,"*")                        
            jobs_arr.each do |value| # print out list of jobs from array
                puts "#{value[:name]}".center(50)
            end
            puts "Enter Job" #need error handling here
            job_name = gets.chomp.capitalize
        end
            
        jobs_arr.each do |job| # check list for correct job
            if job.has_value?(job_name)
                puts "Enter Location"
                location = gets.chomp
                puts "What is your email"
                email = gets.chomp
                puts "Whats is your cell number"
                print "+61"
                phone = gets.chomp
                puts "Quote being processed need four stars "
                print "*"
                contact_arr = [phone,email]
                trip = Travel.new(location)
                print "*"
                distance_cost =trip.travel_cost
                quote = Quote.new(job, distance_cost, location, contact_arr)
                quote.write_quote
                quote.text_quote
                print "*"
                quote.email_quote
                puts "*" 
                puts "Quote sent" 
                puts "Press Enter for main menu"
                gets              
                return                               
            end       
        end
        puts "The job '#{job_name}' does not exist. Would you like to creat this job? [Y/N]"
        if gets.downcase.chomp == "y"
            puts ""
            add_job(jobs_arr, job_name)
            return
        end
    end
end

#Option 2 Add Job main menu
def add_job(jobs_arr, job_name = '')

    if job_name == ''
        puts "Enter Job name"
        job_name = gets.chomp.capitalize
    end    
    puts job_name
    print "Enter materials cost: $"
    materials_cost = gets.to_i
    print "Enter labour time:"
    labour_time = gets.to_i

    jobs_arr.push({name: job_name, materials_cost: materials_cost, time: labour_time})

    puts "#{job_name} Job Added"
    puts "Would you like to create quote? [Y/N]"
    if gets.downcase.chomp == "y"
        puts ""
        quote_menu(jobs_arr_updated, job_name)
        return
    else
        return    
    end
end

def edit_job(jobs_arr)

    puts "Jobs List:".center(50)
    puts "**************************".center(50,"*")                        
    jobs_arr.each do |value| # print out list of jobs from array
        puts "#{value[:name]}".center(50)
    end
    puts "Enter Job you would like to edit" #need error handling here
    job_name = gets.chomp.capitalize
        
    arr_position = 0

    jobs_arr.each do |job| # check list for correct job
        if job.has_value?(job_name)
            # edit job
            puts "What would you like to hours"
            puts "Press 1 to edit name"
            puts "Press 2 to edit materials cost"
            puts "Press 3 to edit how long the job will take (hrs)"
            puts "Press 4 to delete job"
            user_option= gets.to_i
            case user_option
            when 1 #edit name
                print "Enter new name:"
                update_name = gets.chomp.capitalize
                job[:name] = update_name
            when 2# edit materials cost
                print "Enter new materials cost: $"
                update_materials_cost = gets.to_i
                job[:materials_cost] = update_materials_cost
            when 3 #edit hours
                print "Enter new hours:"
                update_hours = gets.chomp.to_i
                job[:time] = update_hours
                puts jobs_arr
            when 4 #delete
                jobs_arr[arr_position] = nil
                jobs_arr.compact!
                puts "Item deleted"
            else
                puts "Wrong selection"
                puts "Enter 1, 2, 3"
            end
            puts "Press Enter for main menu"
            gets              
            return                                   
        end            
        arr_position += 1
    end

    puts "The job '#{job_name}' does not exist. Would you like to creat this job? [Y/N]"
    if gets.downcase.chomp == "y"
        puts ""
        add_job(jobs_arr, job_name)
        return
    else
        return
    end
end 