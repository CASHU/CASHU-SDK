Pod::Spec.new do |s|


    # 1
    s.platform = :ios
    s.ios.deployment_target = '9.0'
    s.name = "CASHU"
    s.summary = "CASHU SDK allows you to integrate your project with CASHU internal services"
    s.requires_arc = true
    
    # 2
    s.version = "1.6"
    
    # 3
     
    s.license      = { :type => 'MIT', :text => <<-LICENSE
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    LICENSE
  }

    # 4 - Replace with your name and e-mail address
    s.author = { "CASHU" => "s.help@cashu.com" }
    
    # 5 - Replace this URL with your own Github page's URL (from the address bar)
    s.homepage = "https://github.com/CASHU/CASHU-SDK"
    
    
    # 6 - Replace this URL with your own Git URL
    s.vendored_frameworks = "CASHU.framework"
    s.source = { :git => "https://github.com/CASHU/CASHU.git"}
    
    # 7
    s.framework = "UIKit"
    s.dependency 'CCMPopup'
    s.dependency 'SCrypto'
    
    # 8
    #s.source_files = "CASHU/**/*.{swift}"
    #s.exclude_files = "CASHU/Private/**/*.{swift}"
    
    # 9
    #s.resources = "CASHU/**/*.{png,jpeg,jpg,storyboard,xib,ttf,plist,xcassets}"
    
    #10
    s.swift_version = "5"
    
    end
    