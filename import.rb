require 'net/https'
require 'json'
require 'uri'

base    = URI('https://mypage.groovecoaster.jp/sp/')
session = ENV.key?('SESSION_ID') ? ENV['SESSION_ID'] : ARGV.shift.to_s

Dir.mkdir('data') unless File.directory?('data')

music_list = []
score_list = []

Net::HTTP.start(base.host, base.port, use_ssl: base.port == 443) do |http|
  music_list_uri = URI.join(base, './json/', 'music_list.php')
  Net::HTTP::Get.new(music_list_uri.request_uri).tap do |req|
    req.add_field 'Cookie', "PHPSESSID=#{session}"
    res = http.request req
    res.value
    music_list.concat JSON.parse(res.body)['music_list']
  end

  music_list.sort_by! do |music_data| music_data['music_id'].to_i end

  music_list.each do |music_data|
    music_id = music_data['music_id']
    score_uri = URI.join(base, './json/', 'music_detail.php')
    score_uri.query = URI.encode_www_form([['music_id', music_id]])
    Net::HTTP::Get.new(score_uri.request_uri).tap do |req|
      req.add_field 'Cookie', "PHPSESSID=#{session}"
      res = http.request req
      res.value
      score_data = JSON.parse(res.body)['music_detail']
      score_list.push score_data
    end
  ensure
    sleep(1.0 + rand(1.5))
  end

  score_list.sort_by! do |score_data| score_data['music_id'].to_i end
end

File.write File.join('data', 'music.json'), JSON.dump(music_list)
File.write File.join('data', 'score.json'), JSON.dump(score_list)