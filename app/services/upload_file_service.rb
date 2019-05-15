class UploadFileService

  def self.random_str
    [*0..9, *'a'..'z', *'A'..'Z'].sample(12).join
  end

  def self.save_file(file)
    public_path = "#{Rails.root}/public"
    file_dir_path = "/images/covers/"
    file_name = "#{random_str}-#{file.original_filename}"

    dir_path = "#{public_path}#{file_dir_path}"
    FileUtils.mkdir(dir_path) unless File.exist?(dir_path)

    file_path = "#{public_path}#{file_dir_path}#{file_name}"
    File.open(file_path,'wb+') do |item| #用二进制对文件进行写入
      item.write(file.read)
    end

    return "#{file_dir_path}#{file_name}"
  end

end
