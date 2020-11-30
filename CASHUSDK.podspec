Pod::Spec.new do |s|


    # 1
    s.platform = :ios
    s.ios.deployment_target = '11.0'
    s.name = "CASHUSDK"
    s.summary = "CASHU SDK allows you to integrate your project with CASHU internal services"
    
    
    # 2
    s.version = "2.0"
    
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
    # s.vendored_frameworks = "CASHU.framework"
    s.source = { :git => "https://github.com/CASHU/CASHU-SDK.git", :tag => s.version.to_s }
  #   s.xcconfig = { "APPLY_RULES_IN_COPY_FILES" => "YES", "STRINGS_FILE_OUTPUT_ENCODING" => "binary" ,"OTHER_LDFLAGS" => "-lz" ,"DEFINES_MODULE" => "YES" }
     s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
    # 7
    s.framework = "UIKit"
    s.dependency 'CCMPopup'
    s.dependency 'SCrypto'
    
   # s.resources = "CASHU/**/*.{png,jpeg,jpg,storyboard,xib,xcassets,lproj,json,plist,strings}"

    s.static_framework = true
    s.requires_arc = true
    # 8
    s.source_files = "CASHU/**/*.{swift}"
    
    # 9
    #s.resource_bundle = { "CASHUSDK" => ["CASHUSDK/Strings/*.lproj/*.strings"] }
    #10
    s.swift_version = "5"


    s.exclude_files = [
        'CASHUSDK/Base.lproj/Main.storyboard',
        'CASHUSDK/Base.lproj/LaunchScreen.storyboard',
        'CASHUSDK/Base.lproj/Main.storyboard',
        'CASHUSDK/ViewController.swift',
        'CASHUSDK/AppDelegate.swift',
        'CASHUSDK/Info.plist',
        'CASHUSDK/Assets.xcassets/AppIcon.appiconset/**',
                            ]

    
    end
    