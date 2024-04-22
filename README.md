# Smart-Contracts

### Smart Contract Verification
Reference:
- [Etherscan Verification](https://etherscan.io/verifyContract) *Though, it can be done through [Remix Plugin](https://remix-ide.readthedocs.io/en/latest/contract_verification.html#etherscan) too.*

### Upload to IPFS using API
Reference: 
- [ERC1155 Dev & Deployment](https://www.youtube.com/watch?v=wYOPh8TX_Tw), 
- [Wizard Contract Developer - OpenZeppelin](https://www.openzeppelin.com/contracts)
- [Pinata IPFS Cloud](https://www.pinata.cloud/) *IPFS Desktop setup can be done to docker but cloud is preferred.*
```
const axios = require('axios')
const FormData = require('form-data')
const fs = require('fs')
const JWT = eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySW5mb3JtYXRpb24iOnsiaWQiOiIxMTE4MGNmMy1mYWIwLTQ3MTItYjg0OS0xODZjNzQwNjk3NWIiLCJlbWFpbCI6Im5vdC5zby5sZXh5QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJwaW5fcG9saWN5Ijp7InJlZ2lvbnMiOlt7ImlkIjoiRlJBMSIsImRlc2lyZWRSZXBsaWNhdGlvbkNvdW50IjoxfSx7ImlkIjoiTllDMSIsImRlc2lyZWRSZXBsaWNhdGlvbkNvdW50IjoxfV0sInZlcnNpb24iOjF9LCJtZmFfZW5hYmxlZCI6ZmFsc2UsInN0YXR1cyI6IkFDVElWRSJ9LCJhdXRoZW50aWNhdGlvblR5cGUiOiJzY29wZWRLZXkiLCJzY29wZWRLZXlLZXkiOiIyOTZlODhmMGJkM2RmZWY4MjUxMCIsInNjb3BlZEtleVNlY3JldCI6ImFlN2VjNzIwMDU0OTFhN2E5NTIzNWY4ZmZiMjY1ZDMyMWE1ZmRhMzEwMTA2ODMwZmI3NzRhNWRkM2NkZmFiNjEiLCJpYXQiOjE3MTM4MTUyNDh9.rJgHcYF-lgVxN3RKgBrJFvvTaFRvO50DsCF6pi_yioI

const pinFileToIPFS = async () => {
    const formData = new FormData();
    const src = "path/to/file.png";
    
    const file = fs.createReadStream(src)
    formData.append('file', file)
    
    const pinataMetadata = JSON.stringify({
      name: 'File name',
    });
    formData.append('pinataMetadata', pinataMetadata);
    
    const pinataOptions = JSON.stringify({
      cidVersion: 0,
    })
    formData.append('pinataOptions', pinataOptions);

    try{
      const res = await axios.post("https://api.pinata.cloud/pinning/pinFileToIPFS", formData, {
        maxBodyLength: "Infinity",
        headers: {
          'Content-Type': `multipart/form-data; boundary=${formData._boundary}`,
          'Authorization': `Bearer ${JWT}`
        }
      });
      console.log(res.data);
    } catch (error) {
      console.log(error);
    }
}
pinFileToIPFS()

```
