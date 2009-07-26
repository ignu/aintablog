require File.dirname(__FILE__) + '/../test_helper'

class TweetTest < ActiveSupport::TestCase
  
  def test_should_create_tweet
    assert_difference 'Tweet.count' do
      tweet = create_tweet
    end
  end
  
  def test_should_know_if_reply_with_colon
    tweet = create_tweet :content => "@somebody: Well I wouldn't say that"
    assert tweet.reply?, "didn't recognize reply with colon"
  end
  
  def test_should_know_if_reply_sans_colon
    tweet = create_tweet :content => "@somebody Well I wouldn't say that"
    assert tweet.reply?, "didn't recognize reply sans colon"
  end
  
  def test_should_not_give_false_positives_for_reply_helper
    tweet = create_tweet :content => "just referencing @somebody"
    assert ! tweet.reply?, "false positive on non-reply"
  end

  def test_should_handle_fix_reply_hacks_when_tweet_starts_with_any_char_and_an_optional_space
    tweet = create_tweet :content => "r @somebody"
    assert tweet.reply?, "didn't recognize fix replies"
    tweet = create_tweet :content => "~@somebody"
    assert tweet.reply?, "didn't recognize fix replies"  
  end
  
protected

  def create_tweet(options={})
    Tweet.create({ :header => 'A name', :content => 'Some content', :user_id => users(:quentin).id, :feed_id => feeds(:one).id, :permalink => 'ok' }.merge(options))
  end
end
