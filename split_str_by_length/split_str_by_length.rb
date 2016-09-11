def split_str_by_length(str, count)
  return [] if str.nil? || count<1
  str.scan(/(((^.{1,#{count}})|((?<=^|[\s-])[\w.,-?!].{0,#{count-1}}))(?=([\s.,-?!])|$))|([\w.,-?!]{1,#{count}})/). \
    map{|e| e.compact.first }
end
