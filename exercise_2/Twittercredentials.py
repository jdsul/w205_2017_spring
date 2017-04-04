import tweepy

consumer_key = "9ywytMVXKVsRxZQA94DyIlVx4";
#eg: consumer_key = "YisfFjiodKtojtUvW4MSEcPm";


consumer_secret = "oRpWD3nPhs2zBnfN6LIsVdfqaNg4Kzsk0gpAvqSRSAUxEuCzI1";
#eg: consumer_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token = "841083468222193665-BcvJNY8PvGto5SjYRh1pCDxKOYcJSj3";
#eg: access_token = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";

access_token_secret = "Vc6wpf3yM1aKVlf9oH9ZvRRwKNyetA7KBIDhpFnxmFmTu";
#eg: access_token_secret = "YisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPmYisfFjiodKtojtUvW4MSEcPm";


auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)



