from dalle2 import Dalle2
# change sess series based on the instruction in github
dalle = Dalle2("sess-Tg4r2bGpwYjx998C40ReoinjotjKcKJNhdhLqCn5") 

# code for generating images with categories and subjectives
import csv
import requests

# change context table
with open('/Users/wenxuan/Desktop/ContextGeneratorDalle2/context_number.csv', newline='') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='\"')
    for row in spamreader:
        print(', '.join(row))
        
        # row[0] = category, row[1] to end = subjectives
        for i in range(1,len(row)):

            # Number of images generate for each combination, minimum is 4, recommend 4 - 8
            num_image_generate = 4
            generations = dalle.generate_amount(row[0].replace("\"", "")+ " " + row[i].replace("\"", "")+ " " + "Texture", num_image_generate)
        
            # save image in url
            for j in range(0,num_image_generate):
                image_url = generations[0][j]['generation']['image_path']
                img_data = requests.get(image_url).content
                with open(row[0].replace("\"", "") +'_'+ row[i].replace("\"", "") + "_"+str(j+1)+'.jpg', 'wb') as handler:
                    handler.write(img_data)
        break