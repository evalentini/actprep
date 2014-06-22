module ApplicationHelper
  def createOptList(optionListHash, setVal=nil)
    optionText=""
    optionListHash.each do |k,v|
      if setVal==v
        optionText=optionText+"<option value=#{v} selected='selected'>#{k}</option>"
      else
        optionText=optionText+"<option value=#{v}>#{k}</option>"
      end
    end
    
    return optionText
  end
end
