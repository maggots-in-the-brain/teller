module ApplicationHelper
  def i18(*args)
    "activerecord.attributes.#{args.map(&:to_s).join(".")}"
  end
end
