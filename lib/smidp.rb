require 'rest-client'
module ShellManager
  class IDP
    def self.ssoHandler(apiKey, token)
      if token == "user_denied"
        '{"code":"user_denied"}'
      else
        begin
          res = RestClient.post "https://monarchshells.com/api/v1/federation/handoff", {key: apiKey, token: token}.to_json
        rescue RestClient::ExceptionWithResponse
          '{"code":"error"}'
        end
        if res.body.present?
          res.body
        else
          '{"code":"failure"}'
        end
      end
    end
    def self.ssoRedirect(pubKey, retUrl)
      "https://monarchshells.com/api/v1/federation/signon?appid=#{pubKey}&redir=#{retUrl}"
    end
  end
end
