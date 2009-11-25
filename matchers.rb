Spec::Matchers.define :apply_interval do |min, max|
  match do |val|
    val >= min and val <= max
  end
end

Spec::Matchers.define :be_MD5 do
  match do |md5|
    md5.length == 32 and md5.instance_of? String and md5 =~ /^[a-f0-9]+$/
  end
end


