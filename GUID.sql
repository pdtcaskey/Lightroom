select hex( randomblob(4)) || '-' || hex( randomblob(2))
             || '-' || '4' || substr( hex( randomblob(2)), 2) || '-'
             || substr('AB89', 1 + (abs(random()) % 4) , 1)  ||
             substr(hex(randomblob(2)), 2) || '-' || hex(randomblob(6)) 
--0642F38B-700F-448F-83BC-28395D233DD1
--4975FB78-5913-4AF1-9A37-DB481CDB578D