# Author: Aotokitsuruya
# Home Page: https://blog.frost.tw
#
# This is a patch to fix `blank?` method not exists

class String
  def blank?
    self.length == 0
  end
end

class Array
  def blank?
    self.length == 0
  end
end

class Fixnum
  def blank?
    self == 0
  end
end

class NilClass
  def blank?
    true
  end
end
