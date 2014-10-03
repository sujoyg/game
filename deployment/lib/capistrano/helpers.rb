class Namespace
  def initialize(hash)
    hash.each do |key, value|
      singleton_class.send(:define_method, key) { value }
    end
  end

  def get
    binding
  end
end

def preprocess(source, options)
  binding = Namespace.new(options).get
  ERB.new(File.read source).result(binding)
end

def copy(source, destination, options={})
  source = File.join Rails.root, "config", "deploy", source
  unless destination[0] == '/'
    destination = File.join deploy_to, 'current', destination
  end

  # Using different files for local and remote staging in case of deployment on the local machine.
  local_staging = File.join "/tmp", Guid.new.to_s
  remote_staging = File.join "/tmp", Guid.new.to_s

  if options.delete(:preprocess)
    File.open(local_staging, "w") do |f|
      f.write preprocess(source, options)
    end

    upload! local_staging, remote_staging, :via => :scp
    File.delete local_staging
  else
    upload! source, remote_staging, :via => :scp
  end

  execute "sudo", "cp --no-preserve all #{remote_staging} #{destination}; rm #{remote_staging}"
end
