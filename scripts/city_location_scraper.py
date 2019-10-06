import bs4 as bs
import urllib.request
import sys

TARGET_CITY_INDEX = 1
TARGET_STATE_INDEX = 2

target_city = sys.argv[TARGET_CITY_INDEX]               #The city to scrape the coordinates of will be passed as the first argument
target_state = sys.argv[TARGET_STATE_INDEX]             #The state to scrape the coordinates of will be passed as the second argument

SEARCH_RESULT_CLASS_NAME = "mw-search-result-heading"   #The name of the class of the div where the Wikidata search results are stored

#Create a URL that will point to the Wikidata search results for the city and state passed into the command line arguments
search_url = "https://www.wikidata.org/w/index.php?search=&search=" + target_city + "+" + target_state

#DEBUG
print("City: " + target_city)
print("State: " + target_state)
#DEBUG

#Open and read the page source of search_url
search_page_source = urllib.request.urlopen(search_url).read()

#Create a soup object to parse the HTML from search_page_source
search_page_soup = bs.BeautifulSoup(search_page_source, "lxml")

#Get the href of the link of the top of the Wikidata results page
top_result_link = search_page_soup.find("div", class_ = SEARCH_RESULT_CLASS_NAME).find("a").get("href")

#Create a URL that points to the WikiData page for the city that's been passed into arguments
information_page_url = "https://www.wikidata.org/" + top_result_link

#Open and read the page soure of information_page_url
information_page_source = urllib.request.urlopen(information_page_url, "lxml")

print()

