class DataFile < ActiveRecord::Base
  attr_accessor :upload
  def save(upload)
    name = upload['datafile'].original_filename
    directory = 'public/data'
    # create the file path
    path = File.join(directory,name)
    # write the file
    File.open(path, "wp") { |f| f.write(upload['datafile'].read)}
  end
end
