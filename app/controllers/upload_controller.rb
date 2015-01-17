class UploadController < ApplicationController
	before_action :authenticate_admin!

    def index
    end

    def parse_time(h,m)
        # unless m==5 || m==0 || m==30
        #     x=h
        #     h=m
        #     m=x
        # end
        # if h<7
        #     h=h+12
        # end
        # if m<=5
        #     m=m*6
        # end
        t=Time.parse("2000-02-02 #{h}:#{m}")
        t = t+Integer(12600)
    end
    def better_y(s)
        return s.to_s.gsub("ي","ی").gsub("ك","ک")
    end


  def add_requirements
    Spreadsheet.client_encoding = 'UTF-8'
    file = File.join(Rails.root, 'public', 'upload', 'data-2.xls')
    doc = Spreadsheet.open file
    errors=Array.new
    doc.worksheets.each_with_index do |sheet,index|
      sheet.each_with_index do |row,i|
        unit = Unit.new
        if i==300
          break
        end
        unless i>=2 && row[0] && row[1]
          next
        end
        unit = Unit.joins(:course).where("courses.code = ?", row[1]).where(:code => row[2]).first
        if unit
          if row[20]
            unit.detail = row[20]
          end
          #if row[21]
          #  if row[20]
          #    unit.detail += "<br>" + row[21]
          #  else
          #    unit.detail = row[21]
          #  end
          #end
          if row[19]
            unit.capacity = row[19].to_int
          end
          unit.save
        end
      end
    end
    puts errors
    render :upload_file
  end
  def upload_file
        my_major_ids={0=>Major.first.id,1=>Major.second.id,2=>Major.third.id}
        days = {4=>3,3=>2,2=>1,1=>0,0=>6}
        t ={"عصر"=>14,"صبح"=>8, "ظهر" => 11}

        Spreadsheet.client_encoding = 'UTF-8'
        #file = File.join(Rails.root, 'public', 'upload', 'data.xls')
        file = File.join(Rails.root, 'public', 'upload', 'data-2.xls')
        doc = Spreadsheet.open file
        #sheet = doc.worksheet 'sheet1'
        i=0
        unless Professor.where(:name => "نامشخص").any?
          Professor.create(:name => "نامشخص")
        end
        doc.worksheets.each_with_index do |sheet,index|
            errors=Array.new

            #TODO set errors && betetr_y

            course = Course.new(:title => "u")
            prof = Professor.new(:name => "u")
            sheet.each_with_index do |row,i|
                unit = Unit.new
                if i==300
                    break
                end
                unless i>=2 && row[0] && row[1]
                    next
                end
                if course.title != row[0].to_s
                    course=Course.where(:title =>better_y(row[0]),:code => row[1].to_s,:unit_num => row[3].to_i)[0]
                    unless course
                        course=Course.create(:title =>better_y(row[0]),:code => row[1].to_s,:unit_num => row[3].to_i,:major_id => my_major_ids[index])
                    end
                    if row[4]=="" || row[4].nil? || row[4]==" "
                        prof=Professor.where(:name => "نامشخص")[0]
                    else
                        prof=Professor.where(:name => row[4].to_s)[0]
                        unless prof
                            prof=Professor.create(:name => row[4].to_s)
                            prof.save
                        end
                    end
                end
                unit.professor=prof
                unit.course=course
                unit.code=row[2].to_s
                unit.term=Term.last
                unit.capacity=(row[12].to_s.match(/^\d+$/) ? row[12].to_i : 0)

                (0..4).each do |day|
                    if row[2*day+5] && row[2*day+5]!="" && row[2*day+5]!=" "

                        #times=row[day].to_s.split("-")
                        #start_t=times[0].gsub(":","/").split("/")
                        #end_t=times[1].gsub(":","/").split("/")
                        # if start_t[1]
                        #   start_t[0], start_t[1] = start_t[1], start_t[0]
                        # else
                        #   start_t[1] = "0"
                        # end
                        # if end_t[1]
                        #   end_t[0], end_t[1] = end_t[1], end_t[0]
                        # else
                        #   end_t[1] = "0"
                        # end
                        # if start_t[0].to_i > end_t[0].to_i
                        #   start_t, end_t = end_t , start_t
                        # end
                        # if start_t[0].to_i < 7
                        #   start_t[0] = start_t[0].to_i + 12
                        #   end_t[0] = end_t[0].to_i + 12
                        # end
                        # unit_time=UnitTime.create(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])
                        # unit_time=UnitTime.where(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])[0]
                        #start_t=row[2*day+5].gsub(":","/").split("/")
                        start_t=[row[2*day+5].hour,row[2*day+5].minute]
                        #end_t=row[2*day+6].gsub(":","/").split("/")
                        end_t=[row[2*day+6].hour,row[2*day+6].minute]
                        unit_time=UnitTime.create(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])
                        unit_time.save
                        unit_time.errors.messages.each do |e|
                            puts "EEEE",e
                        end
                        #puts "ASDSDASDASDAD",start_t,end_t,parse_time(start_t[0].to_i,start_t[1].to_i),unit_time
                        unit_time=UnitTime.where(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])[0]
                        unit.unit_times<<unit_time
                    end
                end

                if row[15] && row[15]!="-" && row[15] != ""
                    # exam_day=row[10].to_s.split("/")[0]
                    # if sheet[i+1,10]
                    #     if sheet[i+1,10].split("-")[1]
                    #         exam_hour=sheet[i+1,10].split("-")[1]
                    #     else
                    #         t[sheet[i+1,10][-3..-1]]
                    #     end
                    # else
                    #     exam_hour=11
                    # end
                    unit.exam_date=DateTime.new(2015,6,row[15].to_i-10,t[row[18]].to_i,0)
                else
                    unit.exam_date=DateTime.new(1900,1,1)
                end
                unless unit.save
                    logger.fatal "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
                    unit.errors.full_messages.each  do |s|
                      logger.fatal s
                    end
                    puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::",unit.errors.full_messages
                    errors.concat(unit.errors.full_messages)
                end
            end
            puts "CCCCCCCCCCCCOOOOOOOOOOOOOOOOONNNNNNNNNNNTTTTTTTTTT",i,errors.count
            errors.each do |e|
                puts "EEEEEEEEEERRRRRRRRRRRRROOOOOOOOOOOOORRRRRRRRRRRRR"
                puts e
                logger.fatal e
            end
        end
  end
  def repair_units
    myDict={}
    User.all.each do |u|
        myDict[u]=Set.new
    end
    my_major_ids={0=>Major.first.id,1=>Major.second.id,2=>Major.third.id}
    days = {4=>3,3=>2,2=>1,1=>0,0=>6}
    t ={"عصر"=>14,"صبح"=>8, "ظهر" => 11}
    Spreadsheet.client_encoding = 'UTF-8'
    file = File.join(Rails.root, 'public', 'upload', 'repair.xls')
    doc = Spreadsheet.open file
    i=0
    unless Professor.where(:name => "نامشخص").any?
      Professor.create(:name => "نامشخص")
    end
    allUnits=Unit.all
    doc.worksheets.each_with_index do |sheet,index|
        errors=Array.new
        course = Course.new(:title => "u")
        prof = Professor.new(:name => "u")
        sheet.each_with_index do |row,i|
            unit = Unit.new
            if i==300
                break
            end
            unless i>=3 && row[0] && row[1]
                next
            end
            #allUs=[]
            myU=nil
            allUnits.each do |a|
                if a.course.code.to_i==row[1].to_i
                    #puts "FFFFFFFFFFFFF",a.code.to_i,row[2].to_i,a.course.code,row[1]
                    if a.code.to_i==row[2].to_i
                        myU=a
                        break
                    end
                end
            end
            # allUs.each do |u|
            #     #puts "CODE",row[2],u.code
            #     #puts "ASDSADASDASD",row[1],u.course.code,u.course.code==row[1],u.course.code==row[1].to_i
            #     if u.course.code==row[1]
            #         #puts "::::::::::::::::::::::::::::::::::","::::::::::::::::::::::::::::::::::::::::::::::::::","::::::::::::::::::::::::::::::::::::::::::::::::::""::::::::::::::::::::::::::::::::::::::::::::::::::"
            #         myU=u
            #         break
            #     end
            # end
            #'''
            if myU
                changed=false
                (0..4).each do |day|
                    if row[3*day+5] && row[3*day+5]!="" && row[3*day+5]!=" "
                        start_t=[row[3*day+5].hour,row[3*day+5].minute]
                        end_t=[row[3*day+6].hour,row[3*day+6].minute]
                        myTime=UnitTime.where(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])[0]
                        next if myTime && myU.unit_times.include?(myTime)
                        changed=true
                        break
                        #myTime=UnitTime.create(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])[0]
                        #unit_time=UnitTime.create(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])
                        # unit_time.save
                        # unit_time.errors.messages.each do |e|
                        #     puts "EEEE",e
                        # end
                        # unit_time=UnitTime.where(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])[0]
                        # unit.unit_times<<unit_time
                    end
                end
                if changed
                    myU.unit_times.delete_all
                    Plan.all.each do |p|
                        if p.units.include?myU
                            myDict[p.user]<<myU.id
                            p.units.delete(myU)
                            p.save
                        end
                    end
                    (0..4).each do |day|
                        if row[3*day+5] && row[3*day+5]!="" && row[3*day+5]!=" "
                        start_t=[row[3*day+5].hour,row[3*day+5].minute]
                        end_t=[row[3*day+6].hour,row[3*day+6].minute]
                        unit_time=UnitTime.create(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])
                        unit_time.save
                        unit_time.errors.messages.each do |e|
                            puts "EEEE",e
                        end
                        unit_time=UnitTime.where(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])[0]
                        myU.unit_times<<unit_time
                        end
                    end
                end             
                next
            end
            if course.title != row[0].to_s
                course=Course.where(:title =>better_y(row[0]),:code => row[1].to_s,:unit_num => row[3].to_i)[0]
                unless course
                    course=Course.create(:title =>better_y(row[0]),:code => row[1].to_s,:unit_num => row[3].to_i,:major_id => my_major_ids[index])
                end
                if row[4]=="" || row[4].nil? || row[4]==" "
                    prof=Professor.where(:name => "نامشخص")[0]
                else
                    prof=Professor.where(:name => row[4].to_s)[0]
                    unless prof
                        prof=Professor.create(:name => row[4].to_s)
                        prof.save
                    end
                end
            end
            unit.professor=prof
            unit.course=course
            unit.code=row[2].to_s
            unit.term=Term.last
            unit.capacity=(row[12].to_s.match(/^\d+$/) ? row[12].to_i : 0)

            (0..4).each do |day|
                if row[3*day+5] && row[3*day+5]!="" && row[3*day+5]!=" "
                    start_t=[row[3*day+5].hour,row[3*day+5].minute]
                    end_t=[row[3*day+6].hour,row[3*day+6].minute]
                    unit_time=UnitTime.create(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])
                    unit_time.save
                    unit_time.errors.messages.each do |e|
                        puts "EEEE",e
                    end
                    unit_time=UnitTime.where(:start_time => parse_time(start_t[0].to_i,start_t[1].to_i),:end_time =>parse_time(end_t[0].to_i,end_t[1].to_i),:day => days[day.to_i])[0]
                    unit.unit_times<<unit_time
                end
            end

            if row[20] && row[20]!="-" && row[20] != ""
                unit.exam_date=DateTime.new(2015,6,row[20].to_i-10,t[row[23]].to_i,0)
            else
                unit.exam_date=DateTime.new(1900,1,1)
            end
            unless unit.save
                logger.fatal "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
                unit.errors.full_messages.each  do |s|
                  logger.fatal s
                end
                puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::",unit.errors.full_messages
                errors.concat(unit.errors.full_messages)
            end
        #'''
        end
        puts "CCCCCCCCCCCCOOOOOOOOOOOOOOOOONNNNNNNNNNNTTTTTTTTTT",i,errors.count
        errors.each do |e|
            puts "EEEEEEEEEERRRRRRRRRRRRROOOOOOOOOOOOORRRRRRRRRRRRR"
            puts e
            logger.fatal e
        end
        File.open("repair_logs.log", "w+") do |f|
          f.write(myDict.size.to_s)
          f.write("\n")
          myDict.each do |d|
            f.write(d[0].id.to_s)
            f.write("\n")
            f.write(d[1].size.to_s)
            f.write("\n")
            d[1].each do |j|
                f.write(j.to_s)
                f.write("\n")
            end
          end
          f.close()
        end
    end
  end
end 
