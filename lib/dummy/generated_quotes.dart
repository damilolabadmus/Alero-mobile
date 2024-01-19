import 'package:flutter/cupertino.dart';

class Quote {
  final String title;
  final String description;

  const Quote({
    @required this.title,
    @required this.description,
  });
}

class Quotes {
  static const List<Quote> data = [
    Quote(
      title: "Finance",
      description:
      "The world's oldest known coin was discovered in Efesos, an ancient Greek city, and dates back to around 625 BCE.",
    ),
    Quote(
      title: "Sport",
      description: "The first Olympic Games for which we still have written records were held in 776 BCE in Olympia, Greece."
    ),
    Quote(
      title: "Geography",
      description: "The Great Wall of China is not visible from the Moon with the naked eye, contrary to popular belief. It is visible from low Earth orbit without aid."
    ),
    Quote(
      title: "Technology",
      description: "The first recorded cyber attack happened in 1834 when two telegraph operators used their privileged positions to engage in stock market fraud."
    ),
    Quote(
      title: "Psychology",
      description: "The 'serial position effect' refers to the tendency of a person to recall the first and last items in a series best, and the middle items worst."
    ),
    Quote(
      title: "Music",
      description: "The longest officially released song is 'The Rise and Fall of Bossanova,' with a duration of 13 hours, 23 minutes, and 32 seconds."
    ),
    Quote(
      title: "Biology",
      description: "A newborn giant panda is about the size of a stick of butter and is one-nine-hundredth the size of its mother."
    ),
    Quote(
      title: "Fashion",
      description: "The bikini was banned in several countries, including Spain and Italy, when it was first introduced in the late 1940s for being too revealing."
    ),
    Quote(
      title: "Food",
      description: "The world's spiciest chili pepper is the Carolina Reaper, with an average Scoville rating of over 1.6 million units."
    ),
    Quote(
      title: "Happiness",
      description: "Listening to music has been shown to stimulate the release of dopamine, a neurotransmitter associated with pleasure and reward, contributing to happiness."
    ),
    Quote(
      title: "Finance",
      description: "The New York Stock Exchange (NYSE) was founded in 1792 when 24 stockbrokers and merchants signed the Buttonwood Agreement under a buttonwood tree on Wall Street."
    ),
    Quote(
      title: "Sport",
      description: "Golf on the Moon was played only once. In 1971, astronaut Alan Shepard hit two golf balls during the Apollo 14 mission."
    ),
    Quote(
      title: "Geography",
      description: "Greenland is the world's largest island, but Australia is often considered an island and a continent."
    ),
    Quote(
      title: "Technology",
      description: "The first known use of the word 'computer' was in 1613, referring to a person who performed calculations or computations."
    ),
    Quote(
      title: "Psychology",
      description: "The 'mere exposure effect' is a psychological phenomenon where people tend to develop a preference for things merely because they are familiar with them."
    ),
    Quote(
      title: "Music",
      description: "The world's largest piano, the Klavins M450, is over 18 feet tall and has strings nearly 30 feet long."
    ),
    Quote(
      title: "Biology",
      description: "Cows have best friends and can become stressed when they are separated from them. They also show excitement when reunited with their friends."
    ),
    Quote(
        title: "Fashion",
        description: "The first recorded fashion show was held in 1858 by English designer Charles Frederick Worth. Models walked the runway to showcase his creations."
    ),
    Quote(
        title: "Food",
        description: "The world's most expensive spice, saffron, comes from the stigma of the Crocus sativus flower. It takes thousands of flowers to produce a small amount of saffron."
    ),
    Quote(
        title: "Happiness",
        description: "Exercise has been linked to increased levels of happiness and well-being, as it releases endorphins, the body's natural mood lifters."
    ),
  ];
}




/// See JSON format data gotten from Alero frontend below
/*const Quotes = [
  {
    title: "Finance",

    description:
    "The world's oldest known coin was discovered in Efesos, an ancient Greek city, and dates back to around 625 BCE."
  },

  {
    title: "Sport",

    description:
    "The first Olympic Games for which we still have written records were held in 776 BCE in Olympia, Greece."
  },

  {
    title: "Geography",

    description:
    "The Great Wall of China is not visible from the Moon with the naked eye, contrary to popular belief. It is visible from low Earth orbit without aid."
  },

  {
    title: "Technology",

    description:
    "The first recorded cyber attack happened in 1834 when two telegraph operators used their privileged positions to engage in stock market fraud."
  },

  {
    title: "Psychology",

    description:
    "The 'serial position effect' refers to the tendency of a person to recall the first and last items in a series best, and the middle items worst."
  },

  {
    title: "Music",

    description:
    "The longest officially released song is 'The Rise and Fall of Bossanova,' with a duration of 13 hours, 23 minutes, and 32 seconds."
  },

  {
    title: "Biology",

    description:
    "A newborn giant panda is about the size of a stick of butter and is one-nine-hundredth the size of its mother."
  },

  {
    title: "Fashion",

    description:
    "The bikini was banned in several countries, including Spain and Italy, when it was first introduced in the late 1940s for being too revealing."
  },

  {
    title: "Food",

    description:
    "The world's spiciest chili pepper is the Carolina Reaper, with an average Scoville rating of over 1.6 million units."
  },

  {
    title: "Happiness",

    description:
    "Listening to music has been shown to stimulate the release of dopamine, a neurotransmitter associated with pleasure and reward, contributing to happiness."
  },

  {
    title: "Finance",

    description:
    "The New York Stock Exchange (NYSE) was founded in 1792 when 24 stockbrokers and merchants signed the Buttonwood Agreement under a buttonwood tree on Wall Street."
  },

  {
    title: "Sport",

    description:
    "Golf on the Moon was played only once. In 1971, astronaut Alan Shepard hit two golf balls during the Apollo 14 mission."
  },

  {
    title: "Geography",

    description:
    "Greenland is the world's largest island, but Australia is often considered an island and a continent."
  },

  {
    title: "Technology",

    description:
    "The first known use of the word 'computer' was in 1613, referring to a person who performed calculations or computations."
  },

  {
    title: "Psychology",

    description:
    "The 'mere exposure effect' is a psychological phenomenon where people tend to develop a preference for things merely because they are familiar with them."
  },

  {
    title: "Music",

    description:
    "The world's largest piano, the Klavins M450, is over 18 feet tall and has strings nearly 30 feet long."
  },

  {
    title: "Biology",

    description:
    "Cows have best friends and can become stressed when they are separated from them. They also show excitement when reunited with their friends."
  },

  {
    title: "Fashion",

    description:
    "The first recorded fashion show was held in 1858 by English designer Charles Frederick Worth. Models walked the runway to showcase his creations."
  },

  {
    title: "Food",

    description:
    "The world's most expensive spice, saffron, comes from the stigma of the Crocus sativus flower. It takes thousands of flowers to produce a small amount of saffron."
  },

  {
    title: "Happiness",

    description:
    "Exercise has been linked to increased levels of happiness and well-being, as it releases endorphins, the body's natural mood lifters."
  },

  {
    title: "Finance",

    description:
    "The concept of insurance dates back to ancient China, where merchants would distribute their goods across multiple vessels to reduce the risk of loss in a single shipment."
  },

  {
    title: "Sport",

    description:
    "The first modern Olympic Games were held in Athens, Greece, in 1896, with 13 participating countries and 241 athletes."
  },

  {
    title: "Geography",

    description:
    "The Great Barrier Reef, located in the Coral Sea off the coast of Queensland, Australia, is the largest coral reef system in the world."
  },

  {
    title: "Technology",

    description:
    "The first computer programmer was Ada Lovelace, who wrote the first algorithm intended for implementation on Charles Babbage's analytical engine."
  },

  {
    title: "Psychology",

    description:
    "The 'bystander effect' is a social psychological phenomenon where individuals are less likely to help in an emergency when other people are present."
  },

  {
    title: "Music",

    description:
    "The world's largest music festival is the Donauinselfest in Vienna, Austria, attracting over 3 million visitors annually."
  },

  {
    title: "Biology",

    description:
    "The smallest bone in the human body is the stapes bone in the ear, measuring only about 0.1 inches (2.5 mm) in length."
  },

  {
    title: "Fashion",

    description:
    "The first fashion magazine, 'Courrier des modes,' was published in France in 1799. It featured illustrations of the latest fashions and accessories."
  },

  {
    title: "Food",

    description:
    "The world's most expensive coffee is made from beans eaten and excreted by the civet, a small mammal. It's known as civet coffee or kopi luwak."
  },

  {
    title: "Happiness",

    description:
    "Practicing gratitude has been linked to increased happiness. Taking time to appreciate what one is thankful for can have positive effects on well-being."
  },
  {
    title: "Finance",
    description:
    "The word 'salary' comes from the Latin word 'salarium,' which originally referred to a payment made to Roman soldiers to purchase salt, an essential commodity."
  },
  {
    title: "Sport",
    description:
    "Basketball was invented by Dr. James Naismith in December 1891. He used peach baskets as goals, and the first game was played with a soccer ball."
  },
  {
    title: "Geography",
    description:
    "Norway is home to the world's longest road tunnel, the Lærdal Tunnel, which stretches over 24.5 kilometers (15.2 miles)."
  },
  {
    title: "Technology",
    description:
    "The QWERTY keyboard layout was designed in 1873 by Christopher Latham Sholes, the inventor of the typewriter, to prevent jamming of mechanical keys."
  },
  {
    title: "Psychology",
    description:
    "The 'Dunning-Kruger effect' is a cognitive bias where individuals with low ability at a task overestimate their ability. It's named after psychologists David Dunning and Justin Kruger."
  },
  {
    title: "Music",
    description:
    "The longest recorded song is 'The Rise and Fall of Bossanova.' It has a duration of 13 hours, 23 minutes, and 32 seconds."
  },
  {
    title: "Biology",
    description:
    "A single gram of soil can contain up to 40,000 different species of microorganisms."
  },
  {
    title: "Fashion",
    description:
    "The stiletto heel was introduced by French designer Roger Vivier in 1954. It was inspired by the slender and sharp stem of a flower."
  },
  {
    title: "Food",
    description:
    "The world's most expensive pizza costs over $12,000 and is topped with a variety of exotic ingredients, including caviar and 24-karat gold flakes."
  },
  {
    title: "Happiness",
    description:
    "Research suggests that spending money on others, also known as 'prosocial spending,' can lead to increased happiness compared to spending on oneself."
  },
  {
    title: "Finance",
    description:
    "The concept of a credit card dates back to the 1920s when Western Union issued metal plates to preferred customers for deferred payment."
  },
  {
    title: "Sport",
    description:
    "The first recorded game of baseball was played in 1846 in Hoboken, New Jersey. The rules were quite different from modern baseball."
  },
  {
    title: "Geography",
    description:
    "The world's driest desert is the Atacama Desert in South America. Some weather stations in this desert have never recorded rainfall."
  },
  {
    title: "Technology",
    description:
    "The first text message ever sent was in 1992 by British engineer Neil Papworth. It simply said, 'Merry Christmas.'"
  },
  {
    title: "Psychology",
    description:
    "The 'Zeigarnik effect' is the psychological phenomenon where people remember uncompleted or interrupted tasks better than completed tasks."
  },
  {
    title: "Music",
    description:
    "The longest-running concert pianist, Ruth Slenczynska, performed professionally for over 80 years, starting at the age of four."
  },
  {
    title: "Biology",
    description:
    "A single strand of human hair can support up to 100 grams in weight. This is stronger than copper wire of the same diameter."
  },
  {
    title: "Fashion",
    description:
    "The high-heeled shoe was initially worn by men in the 10th century as a symbol of status. Women adopted the fashion later."
  },
  {
    title: "Food",
    description:
    "The world's largest hamburger weighed over 2,000 pounds and was cooked in 2012 at a county fair in the United States."
  },
  {
    title: "Happiness",
    description:
    "A 20-second hug releases the bonding hormone oxytocin, which can promote feelings of trust and security, contributing to happiness."
  },
  {
    title: "Finance",
    description:
    "The world's first recorded stock exchange was established in Antwerp, Belgium, in 1460."
  },
  {
    title: "Sport",
    description:
    "Chess is considered a sport by the International Olympic Committee, and it has its own set of doping regulations."
  },
  {
    title: "Geography",
    description:
    "Japan consists of four main islands: Honshu, Hokkaido, Kyushu, and Shikoku, as well as numerous smaller islands."
  },
  {
    title: "Technology",
    description:
    "The first website, created by Tim Berners-Lee, went live on August 6, 1991. It was dedicated to information on the World Wide Web project."
  },
  {
    title: "Psychology",
    description:
    "The 'mere exposure effect' is a psychological phenomenon where people tend to develop a preference for things merely because they are familiar with them."
  },
  {
    title: "Music",
    description:
    "Mozart composed over 600 works, including symphonies, operas, chamber music, and piano sonatas, in his short life of 35 years."
  },
  {
    title: "Biology",
    description:
    "The world's smallest mammal is the bumblebee bat, weighing around 2 grams. It is found in Thailand and Myanmar."
  },
  {
    title: "Fashion",
    description:
    "The first fashion magazine was published in Germany in 1586. It focused on the latest trends in clothing, perfumes, and cosmetics."
  },
  {
    title: "Food",
    description:
    "Chocolate was once used as currency. The Aztecs and Mayans used cacao beans as a form of money and considered chocolate a divine gift."
  },
  {
    title: "Happiness",
    description:
    "Spending time in nature has been linked to increased well-being and happiness. It can reduce stress and improve mood."
  },
  {
    title: "Finance",

    description:
    "The term 'bankrupt' comes from the Italian phrase 'banca rotta,' which means 'broken bench.' In the 15th century, when a money changer went out of business, his bench would be broken to signify his failure."
  },

  {
    title: "Sport",

    description:
    "Golf is the only sport to have been played on the moon. In 1971, astronaut Alan Shepard hit a golf ball on the lunar surface."
  },

  {
    title: "Geography",

    description:
    "Canada has the longest coastline of any country in the world, stretching over 202,080 kilometers (125,567 miles)."
  },

  {
    title: "Technology",

    description:
    "The first computer mouse was made of wood. It was invented by Doug Engelbart in 1964 and had two perpendicular wheels."
  },

  {
    title: "Psychology",

    description:
    "The placebo effect not only works on humans but also on some animals. For example, a study found that giving sugar pills to dogs can reduce pain symptoms."
  },

  {
    title: "Music",

    description: "The Beatles used the word 'love' 613 times in their songs."
  },

  {
    title: "Biology",

    description:
    "A single rainforest can produce 20% of the world's oxygen. The Amazon Rainforest is often referred to as the 'lungs of the Earth.'"
  },

  {
    title: "Fashion",

    description:
    "High heels were originally created for men. In the 10th century, Persian soldiers wore heels to secure their feet in stirrups while riding horses."
  },

  {
    title: "Food",

    description:
    "Ketchup was sold as medicine in the 1830s. It was advertised to cure ailments like diarrhea, indigestion, and jaundice."
  },

  {
    title: "Happiness",

    description:
    "The concept of 'hygge' in Danish culture refers to a quality of coziness and comfortable conviviality that brings a feeling of contentment and well-being."
  },

  {
    title: "Finance",

    description:
    "The world's oldest functioning financial institution is Banca Monte dei Paschi di Siena, founded in 1472 in Italy."
  },

  {
    title: "Sport",

    description:
    "Table tennis originated in England in the late 19th century as an after-dinner activity among the upper class."
  },

  {
    title: "Geography",

    description:
    "Russia is both the largest country by land area and spans 11 time zones."
  },

  {
    title: "Technology",

    description:
    "The first domain name ever registered was 'symbolics.com' on March 15, 1985."
  },

  {
    title: "Psychology",

    description:
    "The color red can increase a person's heart rate and evoke strong emotions, such as love or anger."
  },

  {
    title: "Music",

    description:
    "Beethoven, one of the greatest composers, continued to compose music even after he became completely deaf."
  },

  {
    title: "Biology",

    description:
    "The world's largest living structure is the Great Barrier Reef, stretching over 2,300 kilometers (1,430 miles)."
  },

  {
    title: "Fashion",

    description:
    "Jeans were originally called 'waist overalls' and were created in the 1870s for miners during the Gold Rush in the United States."
  },

  {
    title: "Food",

    description:
    "Peanuts are not nuts; they are legumes. They belong to the same family as beans and lentils."
  },

  {
    title: "Happiness",

    description:
    "The feeling of 'awe' has been linked to increased life satisfaction. Experiencing awe can lead to positive emotions and a sense of connection to something larger than oneself."
  },

  {
    title: "Finance",

    description:
    "The concept of inflation was present in ancient Rome. The Roman government would sometimes debase its currency by reducing the silver content of coins."
  },

  {
    title: "Sport",

    description:
    "The sport of curling originated in 16th-century Scotland and is often referred to as 'chess on ice' due to its strategic nature."
  },

  {
    title: "Geography",

    description:
    "The Dead Sea is one of the saltiest bodies of water in the world, with a salinity of around 30%. It's so dense that people can easily float on its surface."
  },

  {
    title: "Technology",

    description:
    "The first computer virus was created in 1983 and was called the 'Elk Cloner.' It infected Apple II computers through floppy disks."
  },

  {
    title: "Psychology",

    description:
    "The 'mere exposure effect' is a psychological phenomenon where people tend to develop a preference for things merely because they are familiar with them."
  },

  {
    title: "Music",

    description:
    "Mozart was only five years old when he composed his first piece of music, and by the age of eight, he had written his first symphony."
  },

  {
    title: "Biology",

    description:
    "A newborn kangaroo is about 1 inch long and is so underdeveloped that it is unable to hop."
  },

  {
    title: "Fashion",

    description:
    "The bikini, introduced in 1946, was named after the Bikini Atoll, where the U.S. conducted nuclear tests. Its designer, Louis Réard, believed the impact of the revealing two-piece swimsuit would be explosive, just like the atomic bomb."
  },

  {
    title: "Food",

    description:
    "The world's most expensive spice is saffron, derived from the crocus flower. It takes thousands of flowers to produce a single pound of saffron."
  },

  {
    title: "Happiness",

    description:
    "Volunteering has been linked to increased happiness and well-being. Helping others can provide a sense of purpose and fulfillment."
  }
];*/