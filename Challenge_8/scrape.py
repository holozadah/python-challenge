
# coding: utf-8

# In[12]:


from splinter import Browser
from bs4 import BeautifulSoup

# define the browser Google Chrome path and execute it
def init_browser():
    # @NOTE: Replace the path with your actual path to the chromedriver
    executable_path = {"executable_path": "chromedriver"}
    return Browser("chrome", **executable_path, headless=False)

#define the 
def scrape():
    browser = init_browser()
    listings = {}
    #NASA News from nasa.gov website
    url = 'https://mars.nasa.gov/news/?page=0&per_page=40&order=publish_date+desc%2Ccreated_at+desc&search=&category=19%2C165%2C184%2C204&blank_scope=Latest'
    browser.visit(url)
    html = browser.html
    soup = BeautifulSoup(html, 'html.parser')
    listings['news_title'] = soup.find('li',class_='slide').find('div',class_='content_title').find('a').text
    listings['news_p'] = soup.find('li',class_='slide').find('div',class_='article_teaser_body').text
    
    #Extracting the image from www.jpl.nasa.gov
    url = 'https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars'
    browser.visit(url)
    html = browser.html
    soup = BeautifulSoup(html, 'html.parser')
    image= soup.find('a', {'data-title':"Panorama of Vera Rubin Ridge"}).find('div',class_='img').find('img').get('src')
    listings['featured_image_url'] = 'https://www.jpl.nasa.gov'+image

    #Mars Weather from https://twitter.com/MarsWxReport?lang=en
    
    url = 'https://twitter.com/MarsWxReport?lang=en'
    browser.visit(url)
    html = browser.html
    soup = BeautifulSoup(html, 'html.parser')
    # Extracting the mars latest weather
    listings['mars_weather'] = soup.find('li',{"data-item-id":'1041843517113475075'}).find('div',class_="js-tweet-text-container").p.text
    
    
    # Get Mars Hemispheres images urls
    url = 'https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars'
    browser.visit(url)
    html = browser.html
    soup = BeautifulSoup(html, 'html.parser')
    import time
    url_link=[]
    title=[]
    for row in soup.find('div',class_="collapsible results").find_all('div',class_='description'):
        url= row.find('a',href=True)
    #     url_link.append({'title':url.text, 'img_url':'https://astrogeology.usgs.gov'+url['href']})
        url_1 = 'https://astrogeology.usgs.gov'+url['href']
        browser.visit(url_1)
        html = browser.html
        soup = BeautifulSoup(html, 'html.parser')
        url_2 = soup.find('div',class_="downloads").ul.li.find('a',href=True)
        url_link.append({'title':url.text, 'img_url': url_2['href']})
        time.sleep(5)
    listings['hemisphere_image_urls'] = url_link

    return listings


# In[13]:





# ### Extracting the table from https://space-facts.com/mars/

# In[7]:


# from splinter import Browser
# from bs4 import BeautifulSoup
# import pandas as pd
# executable_path = {"executable_path": "chromedriver"}
# browser = Browser("chrome", **executable_path, headless=False)

# url = 'https://space-facts.com/mars/'
# browser.visit(url)
# html = browser.html
# soup = BeautifulSoup(html, 'html.parser')


# In[8]:


# col_1=[]
# col_2=[]

# for i,row in enumerate(soup.find('table', class_="tablepress tablepress-id-mars").tbody.find_all('tr')):
#     col_1.append(row.find('td',class_='column-1').text)
#     col_2.append(row.find('td',class_='column-2').text)
    


# In[9]:


# table = pd.DataFrame(col_2,index=[col_1],columns=['values'])
# table


# In[10]:


# table.to_html('table.html')

