// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved. 
// Licensed under the MIT License. See License.txt in the project root for license information. 
// ------------------------------------------------------------------------------------------------

namespace FingerprintPlugin
{
    using Microsoft.Dynamics.BusinessCentral.Agent.Common;
    using System;

    [AgentPlugin("fingerprint/V1.0")]
    public class Fingerprint : IAgentPlugin
    {
        [PluginMethod("GET")]
        public bool GetConsent(string message)
        {
            var auth = Windows.Security.Credentials.UI.UserConsentVerifier.RequestVerificationAsync(message);
            auth.AsTask().Wait();
            var result = auth.GetResults();
            return result == Windows.Security.Credentials.UI.UserConsentVerificationResult.Verified;
        }
    }
}
