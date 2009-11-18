Spec::Matchers.define :apply_interval do |min, max|
  match do |val|
    val >= min and val <= max
  end
end