import os, sys, glob
from groq import Groq

client = Groq(api_key=os.environ["GROQ_API_KEY"])

tf_files = glob.glob("**/*.tf", recursive=True)
tf_content = ""
for f in tf_files:
    tf_content += f"\n# File: {f}\n" + open(f).read()

response = client.chat.completions.create(
    model="llama-3.3-70b-versatile",
    messages=[
        {"role": "system", "content": open("prompts/system.txt").read()},
        {"role": "user", "content": f"Analyze this Terraform code:\n{tf_content}"}
    ]
)

result = response.choices[0].message.content
print(result)

if "**HIGH**" in result or "HIGH**:" in result or "(HIGH)" in result:
    sys.exit(1)