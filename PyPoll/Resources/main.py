
# coding: utf-8

# # In this challenge, we will be helping a small, rural town modernize its vote-counting process. (Up until now, Uncle Cleetus had been trustfully tallying them one-by-one, but unfortunately, his concentration isn't what it used to be.)# 

# ### Import the required libraries

# In[2]:


import pandas as pd


# ### Read the data from the election_data.csv file

# In[3]:


election = pd.read_csv('election_data.csv')


# ### Explore the data in the election file

# In[4]:


election.head()


# ### Find the total number of votes

# In[6]:


total_votes = len(election)
total_votes


# ### Election results for each candidate

# In[93]:


results = election['Candidate'].value_counts()
results


# In[96]:


election['Candidate'].value_counts().plot.bar()


# ### Calculate the percentage

# In[60]:


percentages = [(percentage/total_votes)*100 for percentage in results]
percentages


# ### The winner name

# In[123]:


max_name = results.idxmax()
max_name


# ### Print out the results of the elections

# In[126]:


print ("Election Results:")
print ("-----------------------------------")
print ("Total Votes: %d"%total_votes)
print ("-----------------------------------")
print ("Khan",str(round(percentages[0],2)) + "%","("+str(results[0])+")")
print ("Correy",str(round(percentages[1],2)) + "%","("+str(results[1])+")")
print ("Li",str(round(percentages[2],2)) + "%","("+str(results[2])+")")
print ("O'Tooley",str(round(percentages[3],2)) + "%","("+str(results[3])+")")
print ("-----------------------------------")
print ("Winner: " + max_name )




# ### Write the results on the text file

# In[128]:


f = open('PyPoll_Results.txt','a')
f.write("Election Results:")
f.write("\n------------------------------------")
f.write("\nTotal Votes: %d"%total_votes)
f.write("\n------------------------------------")
f.write("\nKhan  "+str(round(percentages[0],2)) + "% "+"("+str(results[0])+")")
f.write("\nCorrey  "+str(round(percentages[1],2)) + "% "+"("+str(results[1])+")")
f.write("\nLi  "+str(round(percentages[2],2)) + "% "+"("+str(results[2])+")")
f.write("\nO'Tooley"str(round(percentages[3],2)) + "% ""("+str(results[3])+")")
f.write("\n-----------------------------------")
f.write("\nWinner: " + max_name )
f.close()

