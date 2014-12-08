Pod::Spec.new do |s|
  s.name         = 'MMQreki'
  s.version      = '0.1'
  s.license      = { :type => 'MIT' }
  s.homepage     = 'https://github.com/masajene/MMQreki'
  s.authors      = { 'MasashiMizuno' => '' }
  s.summary      = 'Qreki and Rokuyo Change'

# Source Info
  s.platform     =  :ios, '7.0'
  s.source       = { :git => 'https://github.com/masajene/MMQreki.git', :tag => '0.6.1' }
  s.source_files = 'MMQreki/*.{h,m}'
  #s.framework    =  'CoreLocation', 'CoreBluetooth'

  s.requires_arc = true

end