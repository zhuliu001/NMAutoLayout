    Pod::Spec.new do |s|  
      
      s.name         = "NMAutoLayout" 
      s.version      = "1.0.0"  
      s.summary      = "Make development easier."  
      s.homepage     = "https://github.com/huya-nimo/NMAutoLayout"  
      s.license      = "MIT"  
      s.author       = { "songlinlu" => "lusonglin121@163.com" }  
      s.platform     = :ios, "9.0"  
      s.source       = { :git => "https://github.com/huya-nimo/NMAutoLayout.git", :tag => s.version }  
      s.source_files  = "NMAutoLayout", "NMAutoLayout/*.{h,m}"  
      s.framework  = "UIKit"  
      s.requires_arc = true   
      
    end  