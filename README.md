# Quicode
[Final Report.pdf](https://github.com/SylvieDyer/SeniorProject/files/13638887/Final.Report.pdf)

# 1 Introduction

**1.1 Purpose**

This document provides an overview of the finalized initial release of the Quicode application. It includes background information for the project, outlines the initial scope and functionality, and describes the technical specifications for the application’s frontend and backend. Using these designs, it examines the results of the project, including its compliance with the requirements, and achieved functionality.

**1.2 Background**

As coding becomes a necessary skill for an increasing number of fields, providing access to intuitive, lightweight computer science education becomes increasingly important. This mobile application attempts to address this through short, systematic, gamified practice questions. 
By providing bite-sized lessons to users, this application will cater to audiences in a few manners:
* Users who don’t have large amounts of free time can practice for short periods of time, while building intuition towards computer science.
* Commitment to the app, and learning to code, is not intimidating.
* Gamification will increase engagement, especially for users who are new to computer science
* Content will be an easy, and not intimidating to new learners

Quicode grants its users the freedom to invest as much time as they want into learning, with the flexibility of learning anywhere at any time. Furthermore, we aim to empower individuals to take control of their own learning, and mitigate the friction commonly associated with the first few steps into the world of computer science. 

**1.2.1 Use Cases**

Anticipated use cases fall into three categories:
* Users who have some limited exposure to programming (i.e. through a prior class) and want to maintain and build upon previous knowledge.
* Users completely new to computer science, who want a gradual introduction to computer science without a rigorous, high-commitment curriculum. 
	* This could be especially useful for middle school aged kids.
* Users actively enrolled in an introductory programming course who want some sort of supplemental learning.  

**1.3 Description**

This application aims to integrate incremental learning with the computer science fundamentals to make computer science more accessible to audiences of varying skill sets. It will be gamified through the use of a point tracking system, earned after finishing short lessons. These lessons will be categorized by module, with each module having an overarching topic it is meant to teach. Within each of these modules, topics will be broken down into subcategories, called blocks, and once more into questions 3 difficulty levels: easy, medium, and hard. Each of these sections will involve a series of short, interactive questions that encapsulate important computer science concepts. Users will have targeted questions alike to ones they recently missed from other lessons, and their progress will be reflected in the UI. 

**1.4 Limitations**

While developing Quicode for mobile platforms provides benefits for users who would like to code on-the-go, it also limits the amount of features that the application can provide for the users’ learning experience. For instance, providing a code editor as a learning sandbox is not feasible for a mobile application as compared to a computer-based web application. Additionally, due to the diversity of modern programming languages, keeping content consistent across programming languages gets more complicated for users as the modules dive deeper into the specifics of these concepts. Resultantly, because most languages share the core foundations of computer science, the initial release of Quicode focuses on these basics and fundamentals (i.e. iteration, sequences, conditionals, data types, etc.). Finally, targeting this application towards beginning users as a way to practice their computer science skills limits the application’s target audience. In the future, we hope to extend this application to be a comprehensive platform for computer science such that anyone, from a beginner or a computer science major, could benefit from using Quicode.

**1.5 Differentiation from Similar Applications**

There are many pre existing applications and platforms that focus on computer science education, such as CodeAcademy, FreeCodeCamp, and Khan Academy. Quicode stands apart from these programs by providing a hands-on learning experience through the use of short questions, gamification, and decreasing the amount of time needed to learn. These pre existing platforms tend to involve long articles with detailed descriptions, with less of an emphasis on practice questions. Similarly Quicode is accessible on the go, unlike desktop applications such as Scratch: it allows users to quickly brush up on their coding skills without having to devote time to sit down in front of a computer and run code, or read through long paragraphs of content. Focusing first on basics, fundamentals, and pseudocode before going onto language-specific examples, Quicode allows users to develop a foundation for their computer science intuition. This will then allow them to later learn multiple languages easily due to its interchangeable curriculum, rather than other applications which give users language-specific tracks and examples. In short, Quicode’s accessibility to those with busy schedules, and prioritization of applying knowledge over reading content make it unique to any alternatives. 

# 2 Requirements

**2.1 Scope**

_2.1.1 Scope of Features_

For the initial release, the project scope consists of three main categories: user login and authentication, module content, and user progress tracking. 
When it comes to user login and authentication, Quicode requires users to provide credentials in order to create an account and store their information. These accounts are linked to the progress users make: modules they are completing, and the questions they need to answer. 
The first module, called the Foundational CS Module, will contain blocks which consist of the following topics: data types and variables, operators, conditionals, arrays, and iteration. Each of these blocks will include short conceptual summaries in bite-sized lessons,interactive questions such as multiple choice, multi-select, and drag and drop, and language-specific examples, if applicable. Users will be able to choose any lessons they want to review, or start a new lesson, but must complete one module or block in order to move on to the following one.
User progress tracking will ensure that users complete any necessary lessons required for consequential lessons. This progress tracking will be associated with the user's account, and will be used to enforce the user’s completion of one module or block before moving onto the next one.

_2.1.2 Out of Scope (Future Releases)_

For subsequent releases, granted more time for this project, the scope includes the following: 
1. Support for multiple coding languages
2. Implementing a coding sandbox, for users to compile code and receive feedback 
3. Implementing incremental learning: questions building upon user’s weak points (ML)
4. Allow the user to interact with other users (send direct messages, share progress, etc.)
5. Implementing notifications such as daily reminders, timers, and goal setting and tracking in order to improve gamification
6. Give users access to more detailed and technical information about concepts rather than short overviews 
7. Provide support for other operating systems like Android
8. Curated content with more sophisticated algorithms, potentially AI backed

**2.2 Software Requirements**

Quicode will be developed for use on iOS mobile devices. We chose iOS as the target because iOS offers better uniformity. The standardization, documentation, and simplicity of iOS will benefit our development. We will use iPhones with the latest iOS software for testing, and Apple’s Xcode for development. 
Discussed further in the following sections, our application design will involve a backend component for user authentication, question storage, and user progress tracking. We plan to use a mix of Amazon Web Services’ S3 bucket, DynamoDB, and Apple’s UserDefaults for these purposes. 

# 3 Backend Design Description

This section outlines the requirements for the backend. Our backend will be implemented using Swift and AWS S3’s storage solutions.

_3.1 Login and Authentication_

To login, users will have to use their AppleID. Quicode will leverage Apple’s built-in authentication system to ensure the highest level of security. Once an account is created, the user’s metadata is sent to be stored in DynamoDB. The information is also stored locally using UserDefaults. 

_3.2 Users and User Progress_

To keep track of users, we will use S3 to store each user as a file within the bucket. On DynamoDB, the user id will be affiliated with a progress marker that will allow tracking user progress. Locally, this id will be saved through UserDefaults.

_3.3 Modules, Blocks, Questions, and Content_

Information regarding modules, blocks, questions, and all curriculum related content will be stored in an AWS S3 bucket. AWS S3 will provide a high-performance and cost-effective way to store and retrieve content. This choice allows us to efficiently manage and deliver curriculum-related content while ensuring its accessibility, durability, and scalability. Similarly, requesting this information only when it is needed, we can mitigate the size of this application, and maintain high performance for Quicode. 

# 4 Frontend Design Description

This section outlines the various requirements for the frontend, and the design for different pages the application will include.

**4.1 Overview of Pages**

_4.1.1 Login and User Pages_

These pages will be used to enable users to log into their account on the app, and view stats regarding their progress on each module.

_4.1.2 Home Page_

This page will be the first page users will see after they log in, displaying a list of modules they can complete lessons within. As a user progresses through modules, they will unlock more. In the future, as depicted in the diagram, there will be an option to complete a mini lesson, curated to the user’s weaknesses.

_4.1.3 Module Page_

Within each module, there will be lesson blocks that fall under the overarching module. 

_4.1.4 Block Page_

Each lesson block contains navigation to easy, medium, and hard questions that will test the user on the current topic. These blocks also contain an optional, brief overview of the current topic for users who are unfamiliar with the content.

_4.1.5 Questions_

Following the difficulty selection on the block page, the user will be faced with various types of questions about the current topic. These questions will be presented in one of the following categories: multiple choice, multi-select, or drag and drop. Users can submit their answer, and will be given an unlimited number of attempts to submit the correct answer.

# 5 Results

**5.1 Achieved Functionality**

_5.1.1 Diversified Curriculum_

Curriculum was designed to target users with limited to no exposure to Computer Science. It involves multiple modules, topic blocks, and questions of varying difficulty. 

_5.1.2 User Progress Tracking_

Users earn stars for completing modules, and curriculum is locked if the prerequisites are not met; progress tracking is stored on an AWS DynamoDB table that is organized by user ID. 

_5.1.3 Different Styles of Questions_

Multi-select, multiple choice, drag and drop with varying difficulties are utilized; each question type is developed separately within our repository and applied to the question data files. 

_5.1.4 Question Validation_

Incorrect answers are highlighted on next attempts in order for the users to learn from their mistakes. 

_5.1.5 Topic Overviews_

Each module and block contains a brief overview of the topic to cater to users who are new to computer science. 

_5.1.6 Question of the Day_ 

Daily extra practice to help users remember previous topics they have completed. 

_5.1.7 User Profile_

Users can see account information, total progress, and log out of their account. 

_5.1.8 Integrated AWS S3 Storage for Curriculum_

Module and block names, content overviews, questions are saved here on the AWS S3 bucket and pulled at appropriate locations in the application. This allows for easy modification and scaling in the future. 

_5.1.9 Apple UserDefaults_

Saves user information between sessions to keep users logged in and pick up where they left off.

_5.1.10 Sign in with Apple_

Streamlined user login and authentication. 

**5.2 Compliance with Initial Specifications**

The following details the compliance of the final app with initial specifications. Ultimately, our team was able to comply with all initial requirements, though the scope of these changed a small amount through the development process. Additionally, we were able to achieve some stretch functionality. The following section refers to the specifications outlined in the CSDS 293 Initial Project Proposal Quicode document. 

_5.2.1 User Login/Authentication_

* Initial specifications required users to be able to login, and have new accounts created on the backend. Furthermore, specifications required accounts to be affiliated with app module progress.
	* All of this functionality was achieved.
 
_5.2.2 Modules Consisting of Computer Science Concepts_

* Initial specifications required development of a Foundational CS module, containing learning blocks: data types and variables, operators, boolean expressions, conditionals, sequences, iteration and binary numbers. 
	*All of this functionality was achieved.
 	* Furthermore, additional modules were created that delve into specific programming languages.
* Initial specifications required short conceptual summaries for each module, pseudocode examples and language-specific examples, and multiple interactive question types. Specifications called for ability to review previous lessons.
	* All functionality was achieved.
 
_5.2.3 User progress tracking_

* Initial specifications required a point system to gamify the application. Furthermore, specifications called for module progress tracking, where modules are locked until prerequisite modules are completed.
	* All of this functionality was achieved. 
	* We used a star system rather than a point system. Furthermore, not just module progress was tracked. Block and sub-block (difficulty) data was tracked, locking appropriate sections, and assigning stars as necessary

**5.3 Modified Specifications**

While the vast majority of the scope of this application has stayed the same, we have added some technologies and changed the scope of some features. Namely, we:
* Added use of DynamoDB for user progress tracking, due to ease of data manipulation when compared to S3
* Changed from using Apple’s CoreData to Apple’s UserDefaults, due to technical difficulties in accessing user data after the first login
* Modified curriculum and associated topics based on determined need and further analysis on content
* Implemented a question of the day. A similar feature was considered a stretch goal. 
* Added user progress information in User view
Please note, this may cause discrepancies between this document and previous versions.

**5.4 Services and Packages**

Services Used: AWS S3, AWS DynamoDB, Apple Authentication, Apple UserDefaults
Packages Used: Soto, WrappingHStack

**5.5 Visual Overview**

<img width="623" alt="Screenshot 2023-12-11 at 12 34 19 PM" src="https://github.com/SylvieDyer/SeniorProject/assets/22923306/06245809-506a-48bd-b56b-8f171d01eb68">

