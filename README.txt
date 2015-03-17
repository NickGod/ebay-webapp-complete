In the README file, please include the answers to the following questions: (A succint answer is enough. Please limit your answer to 100 words per question.)

Q1: For which communication(s) do you use the SSL encryption? If you are encrypting the communication from (1) to (2) in Figure 2, for example, write (1)→(2) in your answer.
Q2: How do you ensure that the item was purchased exactly at the Buy_Price of that particular item?
Note: If you get help from any source other than those mentioned in this page, at the end of your README, please clearly cite all references you use, and breifly explain how they help you, such as which portion(s) is/are particularly helpful.

Q1: For communication (4)->(5) we use the SSL encryption. 

Q2: httpSession starts once we have accessed the itemDisplay page of a specific itemID. This session stays alive till we have reached the confirmation page. In this session, every info related to this item will be stored in this session. At stage three, BuyServlet will check whether we open a new session or we are using the one created in itemDisplay page. If there is a new one, it means that info about the item(for instance, Buy_Price), might have been modified. Thus, in this case, we disabled the buy page. In this way, Buy_Price is protected in every session. It cannot be changed during the session.


