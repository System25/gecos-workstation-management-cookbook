#
# Cookbook Name:: gecos_ws_mgmt
# Recipe:: default
#
# Copyright 2013, Junta de Andalucia
# http://www.juntadeandalucia.es/
#
# All rights reserved - EUPL License V 1.1
# http://www.osor.eu/eupl
#

# Global variable $gecos_os created to reduce calls to external programs

$gecos_os = if RUBY_PLATFORM.include?('mingw')
              'windows'
            else
              `lsb_release -d`.split(':')[1].chomp.lstrip
            end

$arch = case node[:kernel][:machine]
        when 'x86_64'
          'amd64'
        when 'i686'
          'i386'
        else
          ''
        end

program_files = if ENV['ProgramFiles(x86)']
                  ENV['ProgramFiles(x86)']
                elsif ENV['ProgramFiles']
                  ENV['ProgramFiles']
                elsif ::File.exist?('C:\\Program Files (x86)')
                  'C:\\Program Files (x86)'
                else
                  'C:\\Program Files'
                end

Chef::Log.info("Program files dir is #{program_files}")

win_tools_dir = program_files + '\\Solutia IT\\GECOS v3\\tools\\'

$gem_path = if ::File.exist?('/opt/chef/embedded/bin/gem')
              '/opt/chef/embedded/bin/gem'
            elsif ::File.exist?('c:\\opscode\\chef\\embedded\\bin\\gem')
              'c:\\opscode\\chef\\embedded\\bin\\gem'
            else
              $gem_path = '/usr/bin/gem'
            end

# Snitch, the chef notifier has been renamed
# TODO: move this to chef-client-wrapper
$snitch_binary = if ::File.exist?('/usr/bin/gecos-snitch-client')
                   '/usr/bin/gecos-snitch-client'
                 elsif ::File.exist?(win_tools_dir +
                   'gecosws-chef-snitch-client.exe')
                   '"' + win_tools_dir + 'gecosws-chef-snitch-client.exe"'
                 else
                   '/usr/bin/gecosws-chef-snitch-client'
                 end

execute 'gecos-snitch-client' do
  command "#{$snitch_binary} --set-active true"
  action :nothing
end.run_action(:run)

# Prepare the environment variables
Chef::Log.info('Prepare the environment variables for '\
    "#{node['ohai_gecos']['pclabel']} computer")
$gecos_environ = ENV.each_with_object({}) { |(k, v), memo| memo[k.to_sym] = v }
$gecos_environ['STATION'.to_sym] = node['ohai_gecos']['pclabel']
$node = node

# Get locale
$locale = ENV['LANG']

windows_codes = {
  '0004' => 'zh_CHS',
  '0401' => 'ar_SA',
  '0402' => 'bg_BG',
  '0403' => 'ca_ES',
  '0404' => 'zh_TW',
  '0405' => 'cs_CZ',
  '0406' => 'da_DK',
  '0407' => 'de_DE',
  '0408' => 'el_GR',
  '0409' => 'en_US',
  '040A' => 'es_ES',
  '040B' => 'fi_FI',
  '040C' => 'fr_FR',
  '040D' => 'he_IL',
  '040E' => 'hu_HU',
  '040F' => 'is_IS',
  '0410' => 'it_IT',
  '0411' => 'ja_JP',
  '0412' => 'ko_KR',
  '0413' => 'nl_NL',
  '0414' => 'nb_NO',
  '0415' => 'pl_PL',
  '0416' => 'pt_BR',
  '0417' => 'rm_CH',
  '0418' => 'ro_RO',
  '0419' => 'ru_RU',
  '041A' => 'hr_HR',
  '041B' => 'sk_SK',
  '041C' => 'sq_AL',
  '041D' => 'sv_SE',
  '041E' => 'th_TH',
  '041F' => 'tr_TR',
  '0420' => 'ur_PK',
  '0421' => 'id_ID',
  '0422' => 'uk_UA',
  '0423' => 'be_BY',
  '0424' => 'sl_SI',
  '0425' => 'et_EE',
  '0426' => 'lv_LV',
  '0427' => 'lt_LT',
  '0428' => 'tg_Cyrl',
  '0429' => 'fa_IR',
  '042A' => 'vi_VN',
  '042B' => 'hy_AM',
  '042C' => 'az_Latn',
  '042D' => 'eu_ES',
  '042E' => 'hsb_DE',
  '042F' => 'mk_MK',
  '0432' => 'tn_ZA',
  '0434' => 'xh_ZA',
  '0435' => 'zu_ZA',
  '0436' => 'af_ZA',
  '0437' => 'ka_GE',
  '0438' => 'fo_FO',
  '0439' => 'hi_IN',
  '043A' => 'mt_MT',
  '043B' => 'se_NO',
  '043e' => 'ms_MY',
  '043F' => 'kk_KZ',
  '0440' => 'ky_KG',
  '0441' => 'sw_KE',
  '0442' => 'tk_TM',
  '0443' => 'uz_Latn',
  '0444' => 'tt_RU',
  '0445' => 'bn_IN',
  '0446' => 'pa_IN',
  '0447' => 'gu_IN',
  '0448' => 'or_IN',
  '0449' => 'ta_IN',
  '044A' => 'te_IN',
  '044B' => 'kn_IN',
  '044C' => 'ml_IN',
  '044D' => 'as_IN',
  '044E' => 'mr_IN',
  '044F' => 'sa_IN',
  '0450' => 'mn_MN',
  '0451' => 'bo_CN',
  '0452' => 'cy_GB',
  '0453' => 'km_KH',
  '0454' => 'lo_LA',
  '0456' => 'gl_ES',
  '0457' => 'kok_IN',
  '0459' => 'sd_Deva',
  '045A' => 'syr_SY',
  '045B' => 'si_LK',
  '045C' => 'chr_Cher',
  '045D' => 'iu_Cans',
  '045E' => 'am_ET',
  '0461' => 'ne_NP',
  '0462' => 'fy_NL',
  '0463' => 'ps_AF',
  '0464' => 'fil_PH',
  '0465' => 'dv_MV',
  '0468' => 'ha_Latn',
  '046A' => 'yo_NG',
  '046B' => 'quz_BO',
  '046C' => 'nso_ZA',
  '046D' => 'ba_RU',
  '046E' => 'lb_LU',
  '046F' => 'kl_GL',
  '0470' => 'ig_NG',
  '0473' => 'ti_ET',
  '0475' => 'haw_US',
  '0478' => 'ii_CN',
  '047A' => 'arn_CL',
  '047C' => 'moh_CA',
  '047E' => 'br_FR',
  '0480' => 'ug_CN',
  '0481' => 'mi_NZ',
  '0482' => 'oc_FR',
  '0483' => 'co_FR',
  '0484' => 'gsw_FR',
  '0485' => 'sah_RU',
  '0486' => 'quc_Latn',
  '0487' => 'rw_RW',
  '0488' => 'wo_SN',
  '048C' => 'prs_AF',
  '0491' => 'gd_GB',
  '0492' => 'ku_Arab',
  '0801' => 'ar_IQ',
  '0803' => 'ca_ES',
  '0804' => 'zh_CN',
  '0807' => 'de_CH',
  '0809' => 'en_GB',
  '080A' => 'es_MX',
  '080C' => 'fr_BE',
  '0810' => 'it_CH',
  '0813' => 'nl_BE',
  '0814' => 'nn_NO',
  '0816' => 'pt_PT',
  '081A' => 'sr_Latn',
  '081D' => 'sv_FI',
  '0820' => 'ur_IN',
  '082C' => 'az_Cyrl',
  '082E' => 'dsb_DE',
  '0832' => 'tn_BW',
  '083B' => 'se_SE',
  '083C' => 'ga_IE',
  '083E' => 'ms_BN',
  '0843' => 'uz_Cyrl',
  '0845' => 'bn_BD',
  '0846' => 'pa_Arab',
  '0849' => 'ta_LK',
  '0850' => 'mn_Mong',
  '0859' => 'sd_Arab',
  '085D' => 'iu_Latn',
  '085F' => 'tzm_Latn',
  '0867' => 'ff_Latn',
  '086B' => 'quz_EC',
  '0873' => 'ti_ER',
  '0C01' => 'ar_EG',
  '0C04' => 'zh_HK',
  '0C07' => 'de_AT',
  '0C09' => 'en_AU',
  '0C0A' => 'es_ES',
  '0C0C' => 'fr_CA',
  '0C1A' => 'sr_Cyrl',
  '0C3B' => 'se_FI',
  '0C6B' => 'quz_PE',
  '4097' => 'ar_LY',
  '4100' => 'zh_SG',
  '4103' => 'de_LU',
  '4105' => 'en_CA',
  '100A' => 'es_GT',
  '100C' => 'fr_CH',
  '101A' => 'hr_BA',
  '103B' => 'smj_NO',
  '105F' => 'tzm_Tfng',
  '5121' => 'ar_DZ',
  '5124' => 'zh_MO',
  '5127' => 'de_LI',
  '5129' => 'en_NZ',
  '140A' => 'es_CR',
  '140C' => 'fr_LU',
  '141A' => 'bs_Latn',
  '143B' => 'smj_SE',
  '6145' => 'ar_MA',
  '6153' => 'en_IE',
  '180A' => 'es_PA',
  '180C' => 'fr_MC',
  '181A' => 'sr_Latn',
  '183B' => 'sma_NO',
  '1C01' => 'ar_TN',
  '1c09' => 'en_ZA',
  '1C0A' => 'es_DO',
  '1C1A' => 'sr_Cyrl',
  '1C3B' => 'sma_SE',
  '2001' => 'ar_OM',
  '2009' => 'en_JM',
  '200A' => 'es_VE',
  '201A' => 'bs_Cyrl',
  '203B' => 'sms_FI',
  '2401' => 'ar_YE',
  '2409' => 'en_CB',
  '240A' => 'es_CO',
  '241A' => 'sr_Latn',
  '243B' => 'smn_FI',
  '2801' => 'ar_SY',
  '2809' => 'en_BZ',
  '280A' => 'es_PE',
  '281A' => 'sr_Cyrl',
  '2C01' => 'ar_JO',
  '2C09' => 'en_TT',
  '2C0A' => 'es_AR',
  '2C1A' => 'sr_Latn',
  '3001' => 'ar_LB',
  '3009' => 'en_ZW',
  '300A' => 'es_EC',
  '301A' => 'sr_Cyrl',
  '3401' => 'ar_KW',
  '3409' => 'en_PH',
  '340A' => 'es_CL',
  '3801' => 'ar_AE',
  '380A' => 'es_UY',
  '3C01' => 'ar_BH',
  '3C0A' => 'es_PY',
  '4001' => 'ar_QA',
  '4009' => 'en_IN',
  '400A' => 'es_BO',
  '4409' => 'en_MY',
  '440A' => 'es_SV',
  '4809' => 'en_SG',
  '480A' => 'es_HN',
  '4C0A' => 'es_NI',
  '500A' => 'es_PR',
  '540A' => 'es_US',
  '7C04' => 'zh_CHT'
}

Chef::Log.info("Platform is #{RUBY_PLATFORM}")
if RUBY_PLATFORM.include? 'mingw'
  unless ENV['Path'].include? 'Windows'
    path = 'C:\\Windows\\system32;'
    path += 'C:\\Windows;'
    path += 'C:\\Windows\\System32\\Wbem;'
    path += 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0;'
    path += win_tools_dir
    ENV['Path'] = path
  end
  Chef::Log.info("PATH is #{ENV['Path']}")

  code = `wmic os get locale | findstr /v Locale`
  code = code.strip.upcase
  Chef::Log.info("Windows code is #{code}")
  $locale = windows_codes[code]
end

$locale = $locale.downcase
$locale = $locale.split('.')[0] if $locale.include? '.'
Chef::Log.info("Locale is #{$locale}")

Chef::Log.info('Enabling GECOS Agent in cron')

unless RUBY_PLATFORM.include?('mingw')
  cron 'GECOS Agent' do
    minute '30'
    command '/usr/bin/gecos-chef-client-wrapper'
    action :create
  end
end

include_recipe 'gecos_ws_mgmt::required_packages'
include_recipe 'gecos_ws_mgmt::software_mgmt'
include_recipe 'gecos_ws_mgmt::misc_mgmt'
include_recipe 'gecos_ws_mgmt::network_mgmt'
include_recipe 'gecos_ws_mgmt::users_mgmt'
include_recipe 'gecos_ws_mgmt::printers_mgmt'
include_recipe 'gecos_ws_mgmt::single_node'

node.normal['use_node'] = {}
node.override['gcc_link'] = true
