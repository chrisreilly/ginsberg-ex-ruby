require 'rest_client'
require 'json'

response = RestClient.post('https://api.project-ginsberg.com/users/login', 
                               {"username" => "allen@project-ginsberg.com",
                                "password" => "howl"}.to_json,
                                :content_type =>:json, :accept =>:json)

parsedJson = JSON.parse(response)

response = RestClient.get('https://api.project-ginsberg.com/users/' + parsedJson["uid"], 
                            {:cookies=> {"sid" => parsedJson["id"]}})

response = RestClient.get('https://api.project-ginsberg.com/obj-fitness?uid='+parsedJson["uid"],
                            {:cookies=> {"sid" => parsedJson["id"]}})

response = RestClient.post('https://api.project-ginsberg.com/obj-fitness',
                            {"uid"=>parsedJson["uid"],
                             "startTimestamp"=>Time.now.to_i,
                             "endTimestamp"=>Time.now.to_i+60,
                             "type"=>"Snowboarding"}, 
                             :cookies=> {"sid" => parsedJson["id"]})
print response
