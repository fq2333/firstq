function theta = my_angle_between_faces(P1,P2)
theta = acos(dot(P1,P2)/norm(P1)/norm(P2))*180/pi;