import com.temboo.core.*;
import com.temboo.Library.Twitter.Search.*;

// Create a session using your Temboo account application details
TembooSession session = new TembooSession("lei", "myFirstApp", "c864b48f63f84b7bbe5e56010318c7f2");

Tweets twitterSearch;
TweetsResultSet tweetsResults;

PImage p1,p2,p3,p4;
// lastID will keep track of the last tweet ID we saw 
// start at 0 to ensure we just get the most recent 100 tweets
// for our search string
String lastID = "0";

int i,r1,r2,r3,r4;


void setup() {
    size(800,800);
  background(255);
  
  p1=loadImage("1.png");
  p2=loadImage("2.png");
  p3=loadImage("3.png");
  p4=loadImage("4.png");
  // Run the Tweets Choreo function
  setupTwitterSearch();

  // testing running the same search but only looking for what's new
  // using setSinceId() (see code in getTweetsResults() and 
  ArrayList test1 = getTweetsResults("costco");
  println("size of test = "+test1.size());
  r1=test1.size();

  println("---------------------------------------");


  ArrayList test2= getTweetsResults("apple");
  println("size of test = "+test2.size());
  r2=test2.size();

  println("---------------------------------------");

  ArrayList test3= getTweetsResults("walmart");
  println("size of test = "+test3.size());
  r3=test3.size();

  println("---------------------------------------");
  
  ArrayList test4= getTweetsResults("target");
  println("size of test = "+test4.size());
  r4=test4.size();

  // // run it again. should report less hits  
  // test = getTweetsResults("black friday");
  // println("size of test = "+test.size());

  // // try one more time. should be less or the same (my test string "movies"
  // // gets tweeted regularly, but it definitely shouldn't jump back up to 100
  // test = getTweetsResults("black friday");
  // println("size of test = "+test.size());
}

void draw(){
   
  image(p1,0,0,r1+100,r1+100);
  image(p2,200,200,r2+100,r2+100);
  image(p3,0,400,r3+100,r3+100);
  image(p4,400,400,r4+100,r4+100);

}


ArrayList getTweetsResults(String q) {
  twitterSearch.setQuery(q);
  twitterSearch.setCount("200");

  // setSinceId says to only get tweets SINCE lastID
  twitterSearch.setSinceId(lastID);

  tweetsResults = twitterSearch.run();
  JSONObject searchResults = parseJSONObject(tweetsResults.getResponse());
  JSONArray statuses = searchResults.getJSONArray("statuses"); // Create a JSON array of the Twitter statuses in the object

  JSONObject tweets;

  try {
    tweets = statuses.getJSONObject(0); // Grab the first tweet and put it in a JSON object
  } 
  catch (Exception e) {
    tweets = null;
  }

  ArrayList results = new ArrayList();

  if (tweets != null) {
    // grab the lastID of the last tweet processed (in reverse order,
    // so we want index 0). this gets used on the NEXT search to ensure
    // we don't get tweets we've already seen
    lastID = statuses.getJSONObject(0).getString("id_str");

    for (int i = 0; i < statuses.size(); i++) {
      String tweetText = statuses.getJSONObject(i).getString("text");
      println(tweetText+"\n");
      results.add(tweetText);
    }
  }
  return results;
}  

void reportSearchesRemaining() {
  println("You have "+tweetsResults.getRemaining()+" searches remaining today.");
}

void setupTwitterSearch() {
  // Create the Choreo object using your Temboo session
  twitterSearch = new Tweets(session);

  // Set inputs
  twitterSearch.setAccessToken("4181030306-3wzRsxACY9Xx8hdtoJZwoC7iRJl4ugkl4f4Hg1v");
  twitterSearch.setAccessTokenSecret("zrvABptstDeGESGiNndzZBJBUq7EwVXKrz0hFdbWFJmjp");
  twitterSearch.setConsumerSecret("knpTcPJzwficvtamkRKPabTPqrA8Q9agRrw5BkZ41ZfJClAPcb");
  twitterSearch.setConsumerKey("y2tTtLsdJngWoW4UlACVO9fHZ");
}