
# coding: utf-8

# # This program is to analyze the financial data of the provided company information. 
# ## The data contains dates and Profit/Lose revenues 
# 
# 
# 

# ### The first step is to import the required library 

# In[3]:


import pandas as pd


# ### Read the budget data 

# In[4]:


data = pd.read_csv("budget_data.csv")


# ### Find the total number of months

# In[5]:


total_months = len(data)
total_months


# ### Find the total Profit and Losses

# In[6]:


total_sum = data['Profit/Losses'].sum()
total_sum


# ### Find the average of the Profit and Losses

# In[7]:


average = data['Profit/Losses'].mean()
average


# ### Find the greatest increase in profits (date and amount) over the entire period

# In[8]:


greatest_increase = data.max()
greatest_increase


# ### Find greatest decrease in losses (date and amount) over the entire period

# In[9]:


greatest_decrease = data.min()
greatest_decrease


# ### Print out the results

# In[10]:


print("Financial Analysis")
print("\n------------------------------------")
print("\nTotal months: %d"%total_months)
print("Total: $%d"%total_sum)
print("Average  Change: $%d"%average)
print("Greatest increase in Profits: %s ($%d)"%(greatest_increase[0],greatest_increase[1]))
print("Greatest decrease in Profits: %s ($%d)"%(greatest_decrease[0],greatest_decrease[1]))


# ### Save the results in text file called results

# In[15]:


f = open('Results.txt','a')
f.write("Financial Analysis")
f.write("\n------------------------------------")
f.write("\nTotal months: %d"%total_months)
f.write("\nTotal: $%d"%total_sum)
f.write("\nAverage  Change: $%d"%average)
f.write("\nGreatest increase in Profits: %s ($%d)"%(greatest_increase[0],greatest_increase[1]))
f.write("\nGreatest decrease in Profits: %s ($%d)"%(greatest_decrease[0],greatest_decrease[1]))
f.close()

