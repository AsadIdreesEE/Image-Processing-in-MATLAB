import cv2
import numpy as np
import tkinter as tk
from tkinter import filedialog

# Function to select an image
def select_image():
    root = tk.Tk()
    root.withdraw()  # Hide the main window
    file_path = filedialog.askopenfilename(title="Select an Image", filetypes=[("Image Files", "*.jpg;*.png;*.jpeg;*.bmp")])
    return file_path

# Get the user-selected image
image_path = select_image()

# Check if an image was selected
if not image_path:
    print("No image selected. Exiting...")
    exit()

# Read the image
img = cv2.imread(image_path)
if img is None:
    print("Error: Image not found or unsupported format!")
    exit()

# Convert to grayscale
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# Apply Gaussian blur
blurred = cv2.GaussianBlur(gray, (5, 5), 0)

# Detect edges using adaptive thresholding
edges = cv2.adaptiveThreshold(blurred, 255, cv2.ADAPTIVE_THRESH_MEAN_C, cv2.THRESH_BINARY, 9, 9)

# Invert colors to make it look like a sketch
sketch = cv2.bitwise_not(edges)

# Show the result
cv2.imshow("Sketch", sketch)

# Save the output image
cv2.imwrite("sketch_output.jpg", sketch)
print("Sketch saved as 'sketch_output.jpg'.")

cv2.waitKey(0)
cv2.destroyAllWindows()
