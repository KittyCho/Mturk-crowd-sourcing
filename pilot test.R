# Care 

install.packages("devtools")
devtools::install_github("RydenButler/labelR")

library(labelR)
library(pyMTurkR)
library (dplyr)
library (tidyverse)
source('key.R')

Sys.setenv(AWS_ACCESS_KEY_ID = access_key)
Sys.setenv(AWS_SECRET_ACCESS_KEY = secret_key)

options(pyMTurkR.sandbox = T)
AccountBalance()



# Qualification Test 


title<-"\nCompleting this training module with a passing score will qualify you to complete Compare Tweets HITs posted by the requester XXX\n"

InstructionOverview<-"\nThis task involves comparing two tweets from Twitter discussing about COVID-19. \nResearchers will use your responses to better understand the message appeals applied to these tweets.\n<br></br>\n<b>Your job is to determine which tweet indicates a more significant level of Care.That is, based only on the two tweets, which one do you feel a stronger sense of Care from it? </b>\n<br></br>\nWhat is meant by Care is explained below.\n"

instruction_list2 <- list( 
  list("A text indicates more a significant levels of Care if there is a stronger sense of compassion/kindness. Two examples are shown below:",
       list("Helen, are you OK? Do you need any help?","Heartbreaking! The man was infected with Coronavirus and died less than two weeks later.")),
  list("A text indicates more a significant levels of Care if there is a stronger sense of nurturance/gentleness. Two examples are shown below:",
       list("The anonymous girl helped the injured people out of the wrecked car and took them to the nearest hospital.","The federal government is spending $2 billion to procure personal protective equipment for front-line workers.")),
  list("A text does NOT indicate a more significant level of Care if:",
       list("\nIt describes an action that is likely not to be conducted for protecting or supporting others, \nand it does not mention the beneficial outcomes of the actions,even in some contexts the action may end up with benefiting others.\n","It solely describes physical or emotional suffering brought by and severity of the pandemic.")),
  "It is important that you read each tweet carefully, and that you judge each by the standards listed above, \nand based only on the information in the text.Do not make your judgments on definitions of Care different to those listed above.\n",
  "Skimming or reading quickly will result in low-quality evaluations, and you may not be invited to participate in our future studies."
)


QuestionPrompt<-"\nPlease read the two tweet texts for each pair. \nYour job is to select the tweet that indicates a more significant level of Care.\n"

PracticeOverview<-"\nWe will provide 6 practice HITs. Please use these examples to learn about Care and How to Complete Compare Tweet Task. \nThese will not be scored and will not count for or against your Compare Tweets qualification.\n"

PracticeQuestions<-list(
  list("The health of the American people is our top priority.",
       "Fake news outlets tell lies.",
       "The correct answer is tweet 1. 
       In tweet 1, the author shows care for American people's health.
       Tweet 2 is about cheating not care."),
  list("If you are a small business and selling online right now leave your information in the comments and feel free to share this and let's help out some people.",
       "It is our honour to play our part alongside all Americans.",
       "The correct answer is tweet 1.
       In tweet 1, the author indicates that he is helping out businessman.
       Tweet 2 is about loyalty not care."),
  list("As the numbers continue to rise, we can never forget that there are real people, each with their own lives, stories, families, and friends behind every statistic.",
       "Just follow the orders of your leaders even when others disobey.",
       "The correct answer is tweet 1. 
       Tweet 1 shows sympathy to lives which is a type of care. 
       Tweet 2 is about authority not care."),
  list("My heart is with all those who have lost someone to COVID-19.",
       "He overate just to get relief from the stress while he stayed at home during the pandemic.",
       "The correct answer is tweet 1.
       Tweet 1 shows sympathy to those who lost someone to COVID which is kindness and care. 
       Tweet 2 is about degradation not care."),
  list("Protect yourself and your community from coronavirus with common sense precautions: wash your hands and stay home when sick.",
       "We need to organize a parade against the notorious restrictions to win back our freedom.",
       "The correct answer is tweet 1. 
       In Tweet 1, author gives advice to others with an explicitly stated intention of protecting others, which is care
       Tweet 2 is about liberty not care."),
  list("Chinese billionaire Jack Ma, co-founder of Alibaba, says he will donate masks, test kits and protective suits to all countries in Africa to help the continent in its fight against the novel coronavirus.",
       "55% of restaurants are already closed due to the pandemic.",
       "The correct answer is tweet 1.
       In tweet 1, A billionaire said he would make donations to help African people which is care. 
       Tweet 2 is not about any morality.")
)



TestOverview<-"\nWe will give you 6 example HITs to complete. \nTo receive the qualification for the Compare Tweet task, you must complete 5 out of 6 of these example HITs correctly.\n"


TestQuestions<-list(
  list("Our top priority during this challenging time is the health and safety of our employees, contractors and our communities.",
       "The girl believed that faith in God makes everything possible, including a victory in the fight against covid.",
       1),
  list("I feel like I'm losing freedom when I am told that I have no choice but to wear a mask in public.",
       "I feel terribly sorry for what your suffering. Believe me, you are not alone.",
       2),
  list("The poor boy just does what he is asked to do without any complaints.",
       "FHFA has released new guidance on how they are helping FannieMae and FreddieMac customers during the COVID-19 pandemic.",
       2),
  list("Make your gift go further to support vulnerable families.",
       "All community members are united together to help each other throughout the disaster.",
       1),
  list("I would never have imagined a tragedy like this could happen to Ben's family. It’s so heartbreaking.",
       "Women deserve equal pay for equal work.",
       1),
  list("I want to share my experience especially with those around my age to help bring awareness, and to relieve any stress some may have due to the pandemic.",
       "Receptors for Coronavirus are deep in a person’s lungs.",
       1)
)


ClosingMessage<-"<br></br>Please continue to fully read each tweet text and provide your best answer. \nYour performance will be monitored as you complete more HITs.\nIf you provide poor quality answers, all of your work will be rejected and your Compare Tweets qualification will be revoked.<br></br>"



QualTest2 <- formatTest(title = title,
                        instruction_overview = InstructionOverview,
                        instruction_list = instruction_list2,
                        question_prompt = QuestionPrompt,
                        practice_overview = PracticeOverview,
                        practice_questions = PracticeQuestions,
                        test_overview = TestOverview,
                        test_questions = TestQuestions,
                        closing_message = ClosingMessage)



Description <- 'Qualify workers to participate in Compare Tweets HITs'


QualificationWithTest_moral <- CreateQualificationType(name = 'Qualifcations for CARE(for edit)',
                                                       description = Description,
                                                       status = 'Active',
                                                       test = QualTest2$Questions,
                                                       answerkey = QualTest2$Answers,
                                                       test.duration = 60 * 60,
                                                       retry.delay = 0)



#   2. making HIT   # 

ShortInstructions<-list("For each pair of tweets, pick the tweet that indicates a more significant level of Care")

InstructionList2 <- list(
  list("A text indicates a more significant level of Care if there is a stronger sense of compassion/kindness:",
       list("Helen, are you OK? Do you need any help?","Heartbreaking! The man was infected with Coronavirus and died less than two weeks later.")),
  list("A text indicates a more significant level of Care if there is a stronger sense of nurturance/gentleness:",
       list("The anonymous girl helped the injured people out of the wrecked car and took them to the nearest hospital.","The federal government is spending $2 billion to procure personal protective equipment for front-line workers.")),
  list("A text does NOT indicate more significant levels of Care if:",
       list("It describes an action that is likely not to be conducted for protecting or supporting others, and it does not mention the action’s beneficial outcomes, even in some contexts the action may end up with benefiting others.","It solely describes physical or emotional suffering brought by and severity of the pandemic.")),
  "It is important that you read each tweet carefully, and that you judge each by the standards listed above, and based only on the information in the text.Do not make your judgments on definitions of Care different to those listed above.",
  "Skimming or reading quickly will result in low-quality evaluations, and you may not be invited to participate in our future studies.")


HIT_code <- formatHIT(question_prompt = 'Which tweet indicates a more significant level of Care?',
                      short_instruction_list = ShortInstructions,
                      instruction_overview = InstructionOverview,
                      instruction_list = InstructionList2,
                      closing_message = ClosingMessage)



#  3. send HITs to Mturk  # 

documents<-read.csv("final coding sample 500 tweets month.csv")
documents<-data.frame(doc_ids=documents$X,doc_text=documents$content)

set.seed(1234)
doc1<-as.data.frame(sample(x = documents$doc_ids, size = 5,replace=F))
doc1<-as.data.frame(doc1[rep(seq_len(nrow(doc1)),each=2),])
names(doc1)<-c("tweet1")
# 5 unique tweets, 2 pairs per tweet 


documents<-documents%>%
  filter(!doc_ids%in%doc1$tweet1 )

set.seed(1234)
doc2<-as.data.frame(sample(x = documents$doc_ids, size = 5*2))
names(doc2)<-c("tweet2")

doc1$tweet2<-doc2$tweet2

Comparisons <- t(apply(doc1, 1, function(x) documents$doc_text[x]))

current_HITs <- sendComparisons(hit_type = '3GC398RH53WSREG3G7KZAMYJPJXPK4', # HIT type id from MTurk requester dashboard
                                hit_layout = '3AZNMMRL9EQJGKPDVL36VLPAZRYFJU', # HIT layout id from MTurk requester dashboard
                                comparisons_to_send = Comparisons)

 
write.csv(Comparisons,"Comparisons.csv")




