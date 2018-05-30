Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "CASHU"
s.summary = "CASHU SDK allows you to integrate your project with CASHU internal services"
s.requires_arc = true

# 2
s.version = "1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "CASHU" => "s.help@cashu.com" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
#s.homepage = "[Your RWPickFlavor Homepage URL Goes Here]"

# For example,
s.homepage = "https://github.com/JRG-Developer/RWPickFlavor"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "/Users/ahmedabdel-samie/Library/Developer/Xcode/DerivedData/CASHU-endyfpioopowoddkuuykgkaunmjb/Build/Products/", :tag => "#{s.version}"}

# 7
s.framework = "UIKit"
s.dependency 'CCMPopup'

# 8
s.source_files = "CASHU/**/*.{swift}"

# 9
s.resources = "CASHU/**/*.{png,jpeg,jpg,storyboard,xib}"
end
